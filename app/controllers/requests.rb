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
    @space = Space.first(availabledates: { requests: { request_id: params[:id] } })
    @from = User.first(requests: { request_id: params[:id]})
    @date = Availabledate.first(requests: { request_id: params[:id]})
    erb(:"requests/id")
  end

  post '/requests/:id' do
    req = Request.all(request_id: params[:id])
    req.update(status: params[:response])
    redirect '/requests'
  end
end
