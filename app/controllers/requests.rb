class MakersBnB < Sinatra::Base

  post '/requests/new' do

    availabledate = []
    params.each_pair{|key, value| availabledate << Availabledate.get(value)}
    availabledate.each{|a_date| Request.create(user_id: current_user.id,
                                               availabledate_id: a_date.id,
                                               status: "open")}

    redirect '/requests'
  end

  get '/requests' do

    redirect '/spaces' unless current_user


    @requests_made = Request.all(user_id: current_user.id)
    # @available = Availabledate.first(id: @requests_made.availabledate_id)
    # @space = Space.first(id: @available.space_id)
    # @owner = User.first(id: @space.user_id)

    @space_requested = Space.all(availabledates: { requests: { user_id: current_user.id } })
    # @space_requested = Space.first(availabledates: @available.id)

    p @space_requested
    p @requests_made
    # p @available
    # p @space
    # p @owner
    # @requests_received Request.all(availabledate => {})

    erb(:requests)
  end


end
