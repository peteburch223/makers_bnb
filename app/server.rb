class MakersBnB < Sinatra::Base
  enable :sessions
  register Sinatra::Flash
  register Sinatra::Partial
  use Rack::MethodOverride
  set :session_secret, 'super secret'
  set :partial_template_engine, :erb

  register Gon::Sinatra

  enable :partial_underscores
  include Helpers

  get '/' do
    redirect '/spaces' if current_user
    erb :index
  end
end
