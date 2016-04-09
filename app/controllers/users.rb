class MakersBnB < Sinatra::Base
  post '/users/new' do
    @user = User.new(email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      message = "Hello, #{current_user.email}!\n"\
      'We hope you enjoy letting strangers into your own home...'
      send_email(body: message)
      redirect to '/spaces'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :index
    end
  end
end
