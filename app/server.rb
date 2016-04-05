class MakersBnB < Sinatra::Base
<<<<<<< HEAD

=======
>>>>>>> 1c6d8fb21a352556779fcaf96992bf271635a48c
  enable :sessions
  register Sinatra::Flash
  register Sinatra::Partial
  use Rack::MethodOverride
  set :session_secret, 'super secret'
  set :partial_template_engine, :erb

  enable :partial_underscores

  get '/' do
<<<<<<< HEAD
    erb :index
=======

>>>>>>> 1c6d8fb21a352556779fcaf96992bf271635a48c
  end

end
