class MakersBnB < Sinatra::Base
  post '/requests/new' do
    redirect '/spaces' unless current_user
    redirect '/requests' if params.empty?
    availabledate = []
    ids = params[:availabledate_id].split(',').map(&:to_i)
    ids.each { |id| availabledate << Availabledate.get(id) }

    make_request(availabledate)

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
    @space = Space.first(
      availabledates: { requests: { request_id: params[:id] } })
    @from = User.first(requests: { request_id: params[:id] })
    @date = Availabledate.first(requests: { request_id: params[:id] })
    erb(:"requests/id")
  end

  post '/requests/:id' do
    req = Request.all(request_id: params[:id])
    req.update(status: params[:response])
    requester = User.first(id: req[0].user_id)
    space = Space.first(availabledates: { requests: { id: params[:id] } })

    booking_confirmation_emails(params, space, requester)
    redirect '/requests'
  end
end
