class MakersBnB < Sinatra::Base
  get '/spaces' do
    @spaces = available_dates(params)
    erb(:spaces)
  end

  get '/spaces/new' do
    erb(:'spaces/new')
  end

  post '/spaces/new' do
    create_space(params)
    redirect '/spaces'
  end

  get '/spaces/:id' do
    @space = Space.get(params[:id].to_i)

    erb(:"spaces/id")
  end
end
