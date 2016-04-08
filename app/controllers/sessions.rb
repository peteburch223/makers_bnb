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
      flash.next[:errors] = ['The email or password is incorrect']
      redirect '/'
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    redirect '/'
  end
end
