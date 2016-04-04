class MakersBnB < Sinatra::Base


  get '/spaces' do
    erb(:spaces)
  end

  get '/spaces/new' do
    erb(:'spaces/new')
  end

  post '/spaces/new' do
    redirect '/spaces'
  end

end
