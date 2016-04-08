class MakersBnB < Sinatra::Base
  post '/requests/new' do
    redirect '/spaces' unless current_user
    redirect '/requests' if params.empty?
    availabledate = []
    ids = params[:availabledate_id].split(',').map(&:to_i)
    ids = [*ids[0]..ids[1]] unless ids.length == 1
    ids.pop unless ids.length == 1
    ids.each { |id| availabledate << Availabledate.get(id) }

    request_id = Request.max(:request_id)
    request_id = (request_id.nil? ? 1 : request_id + 1)
    availabledate.each do |a_date|
      Request.create(user_id: current_user.id,
                     availabledate_id: a_date.id,
                     status: Helpers::NOT_CONFIRMED,
                     request_id: request_id)
    end

    redirect '/requests'
  end

  get '/requests' do
    redirect '/spaces' unless current_user
    @space_requests_made = requests_made
    @space_requests_received = requests_received
    erb(:requests)
  end


  get '/requests/:id' do
    @request_id = params[:id]
    @space = Space.first(availabledates: { requests: { id: params[:id] } })
    @from = User.first(requests: { id: params[:id]})
    @date = Availabledate.first(requests: { id: params[:id]})
    erb(:"requests/id")
  end

  post '/requests/:id' do
    req = Request.all(id: params[:id])
    req.update(status: params[:response])
    redirect '/requests'
  end

  def requests_made
    requests_made = Request.all(user_id: current_user.id, :fields => [:user_id, :request_id], :unique => true, :order => nil)
    space_requests_made = []
    requests_made.each do |req|
      space_requests_made << Space.first(availabledates: { requests: { user_id: current_user.id, request_id: req.request_id } })
    end
    prepare_request_display(space_requests_made)
  end

  def requests_received
    # puts "*****RECEIVED******"
    requests = Request.all()
    # p requests
    return [] if requests.nil?
    requests_received = []
    requests.each do |req|
      # p req
      # p req.availabledate.space.user_id
      requests_received << req.id if req.availabledate.space.user_id == current_user.id
    end

    # p requests_received

    space_requests_received = []
    requests_received.each do |id|

      # p id
      # p Space.first(availabledates: { requests: {request_id: id } })
      space_requests_received << Space.first(availabledates: { requests: {request_id: id } })
    end
    # puts "space_requests_received"
    # p space_requests_received

    # need to understand why we need to compact...where are the nils coming from?

    stuff = space_requests_received.compact
    # p stuff
    temp = prepare_request_display(stuff)
    # puts "temp"
    # p temp
    temp
  end

  def prepare_request_display(space_requests)
    # puts "prepare_request_displayn - before guard clause"
    #     p space_requests
  return [] if space_requests.nil?
    # puts "prepare_request_display"
    return_value = []
    # p space_requests
    space_requests.each do |space|
      # p space
      result = []
      result << space
      result << space.availabledates.requests.first.status
      result << space.availabledates.first.avail_date.strftime('%d %m %Y') + (' - ' + space.availabledates.last.avail_date.strftime('%d %m %Y') if space.availabledates.count > 1)
      result << space.availabledates.requests.first.id.to_s
      return_value << result
    end
    return_value
  end
end
