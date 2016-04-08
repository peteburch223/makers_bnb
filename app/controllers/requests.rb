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
end
