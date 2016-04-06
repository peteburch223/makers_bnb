class MakersBnB < Sinatra::Base
  get '/spaces' do
    @spaces = available_dates(params)
    erb(:spaces)
  end

  get '/spaces/new' do
    redirect '/spaces' unless current_user
    erb(:'spaces/new')
  end

  post '/spaces/new' do
    redirect '/spaces' unless current_user
    create_space(params)
    redirect '/spaces'
  end

  get '/spaces/:id' do
    @space = Space.get(params[:id].to_i)
    @available = Availabledate.all(space_id: @space.id)
    erb(:"spaces/id")
  end
end
