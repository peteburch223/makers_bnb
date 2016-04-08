class MakersBnB < Sinatra::Base
  post '/requests/new' do
    redirect '/spaces' unless current_user
    redirect '/requests' if params.empty?
    availabledate = []
    ids = params[:availabledate_id].split(',').map(&:to_i)
    ids = [*ids[0]..ids[1]] unless ids.length == 1
    ids.pop unless ids.length == 1
    ids.each { |id| availabledate << Availabledate.get(id) }
    
    make_request(availabledate, ids)

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
    @space = Space.first(availabledates: { requests: { request_id: params[:id] } })
    @from = User.first(requests: { request_id: params[:id]})
    @date = Availabledate.first(requests: { request_id: params[:id]})
    erb(:"requests/id")
  end

  post '/requests/:id' do
    req = Request.all(request_id: params[:id])
    req.update(status: params[:response])
    requester = User.first(id: req[0].user_id)
    space = Space.first(availabledates: { requests: { id: params[:id] } })

    send_email(to: requester.email, subject: "Your request for #{space.name} has been #{params[:response].downcase}",
               body: email_responses)
    send_email(to: current_user.email, subject: "You've #{params[:response].downcase} #{requester.email}'s request",
               body: email_responses)
    redirect '/requests'
  end

  def requests_made
    requests_made = Request.all(user_id: current_user.id, :fields => [:user_id, :request_id], :unique => true, :order => nil)
    space_requests_made = []
    requests_made.each do |req|
      result =[]
      result << Space.first(availabledates: { requests: { user_id: current_user.id, request_id: req.request_id } })
      result << req.request_id
      space_requests_made << result
    end
    prepare_request_display_array(space_requests_made)
  end

  def requests_received
    requests = Request.all()
    return [] if requests.nil?
    requests_received = []
    requests.each do |req|
      requests_received << req.request_id if req.availabledate.space.user_id == current_user.id
    end

    requests_received.uniq!
    space_requests_received = []

    requests_received.each do |id|
      result =[]
      result << Space.first(availabledates: { requests: {request_id: id } })
      result << id
      space_requests_received << result
    end
    prepare_request_display_array(space_requests_received)
  end

  def prepare_request_display_array(space_request_arrays)
    return [] if space_request_arrays.nil?
    return_value = []
    space_request_arrays.each do |space|
      result = []
      result << space.first
      result << Request.first(request_id: space.last).status
      dates = Availabledate.all(requests: {request_id: space.last})
      result << dates.first.avail_date.strftime('%d/%m/%Y') + ((' - ' + dates.last.avail_date.strftime('%d/%m/%Y') if dates.count > 1) || "")
      result << space.last.to_s
      return_value << result
    end
    return_value
  end
end
