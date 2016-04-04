class MakersBnB < Sinatra::Base

  post '/users/new' do
    @user = User.new(email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/spaces'
    else
      flash.next[:errors] = @user.errors.full_messages
      redirect '/'
    end
  end

end
