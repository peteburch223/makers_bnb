class MakersBnB < Sinatra::Base

  post '/requests/new' do
    puts "THIS IS A TEST XXXXXXXX"


    availabledate = []
    params.each_pair{|key, value| availabledate << Availabledate.get(value)}
    availabledate.each{|a_date| Request.create(user_id: current_user.id,
                                               availabledate_id: a_date.id,
                                               status: "open")}

    redirect '/requests'
  end

  get '/requests' do

    redirect '/spaces' unless current_user
    @requests_made = Request.all()
    @requests_received

    erb(:requests)
  end


end
