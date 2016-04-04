class MakersBnB < Sinatra::Base


  get '/spaces' do
    @spaces = Space.all
    erb(:spaces)
  end

  get '/spaces/new' do
    erb(:'spaces/new')
  end

  post '/spaces/new' do
    p params[:price]
    Space.create(name: params[:name],
                 description: params[:description],
                 price: params[:price])
    redirect '/spaces'
  end

end
