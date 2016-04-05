class MakersBnB < Sinatra::Base

  get '/sessions/new' do
    erb(:"sessions/new")
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect '/spaces'
    else
      flash.now[:errors] = user.errors.full_messages
      erb(:"sessions/new")
    end
  end

end
