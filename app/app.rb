ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'data_mapper_setup'
# require 'controllers/users'

class MakersBnB < Sinatra::Base
  register Sinatra::Flash
  get '/' do
    erb :index
  end

  post '/users/new' do
    @user = User.new(email: params[:email],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect to '/spaces'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb :index
    end
  end

  run! if app_file == $0
end
