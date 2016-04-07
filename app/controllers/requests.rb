require 'byebug'


class MakersBnB < Sinatra::Base

  # post '/requests/new' do
  #   redirect '/spaces' unless current_user
  #   redirect '/requests' if params.empty?
  #   availabledate = []
  #   id_array = params[:availabledate_id].split(',').sort
  #   id_array = [*(id_array[0].to_i)..(id_array[1].to_i)]
  #   id_array.each { |id| availabledate << Availabledate.get(id) }
  #   availabledate.each do |a_date|
  #     Request.create(user_id: current_user.id,
  #                    availabledate_id: a_date.id,
  #                    status: Helpers::NOT_CONFIRMED)
  #                  end
  #    redirect '/requests'
  # end

  post '/requests/new' do

    availabledate = []
    params.each_pair{|key, value| availabledate << Availabledate.get(value)}
    #----------------- CALENDAR INPUT TO COME -------------------------------

    request_id = Request.max(:request_id)
    request_id = (request_id.nil? ? 1 : request_id + 1)


    availabledate.each{|a_date| Request.create(user_id: current_user.id,
                                               availabledate_id: a_date.id,
                                               status: Helpers::NOT_CONFIRMED,
                                               request_id: request_id)}
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
    request = Request.all(id: params[:id])
    request.update(status: params[:response])
    redirect '/requests'
  end

  def requests_made
    requests_made = Request.all(user_id: current_user.id, :fields => [:user_id, :request_id], :unique => true, :order => nil)
    space_requests_made = []
    requests_made.each do |request|
      space_requests_made << Space.first(availabledates: { requests: { user_id: current_user.id, request_id: request.request_id } })
    end
    prepare_request_display(space_requests_made)
  end

  def requests_received
    requests = Request.all()
    return [] if requests.nil?
    requests_received = []
    requests.each do |request|
      requests_received << request.id if request.availabledate.space.user_id == current_user.id
    end

    space_requests_received = []
    requests_received.each do |id|
      space_requests_received << Space.first(availabledates: { requests: {request_id: id } })
    end

    # need to understand why we need to compact...where are the nils coming from?
    prepare_request_display(space_requests_received.compact!)
  end

  def prepare_request_display(space_requests)
    return [] if space_requests.nil?
    return_value = []
    space_requests.each do |space|
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
