class MakersBnB < Sinatra::Base

  post '/requests/new' do

    availabledate = []
    params.each_pair{|key, value| availabledate << Availabledate.get(value)}
    #----------------- CALENDAR INPUT TO COME -------------------------------
    availabledate.each{|a_date| Request.create(user_id: current_user.id,
                                               availabledate_id: a_date.id,
                                               status: "open",
                                               space_id: a_date.space_id)}
    redirect '/requests'
  end

  get '/requests' do

    redirect '/spaces' unless current_user

    @space_requests_made = Space.all(availabledates: { requests: { user_id: current_user.id } })
    @space_requests_received = Space.all(user_id: current_user.id)
    @space_requests_received.reject!{|space| space.availabledates.requests.empty?}

    erb(:requests)
  end


end
