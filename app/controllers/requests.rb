class MakersBnB < Sinatra::Base
  post '/requests/new' do
    redirect '/spaces' unless current_user
    redirect '/requests' if params.empty?
    availabledate = []
    id_array = params[:availabledate_id].split(',').sort
    id_array = [*(id_array[0].to_i)..(id_array[1].to_i)]
    id_array.each { |id| availabledate << Availabledate.get(id) }
    availabledate.each do |a_date|
      Request.create(user_id: current_user.id,
                     availabledate_id: a_date.id,
                     status: 'open')
    end
    redirect '/requests'
  end

  get '/requests' do
    redirect '/spaces' unless current_user

    @space_requests_made = Space.all(availabledates: { requests: { user_id: current_user.id } })
    @space_requests_received = Space.all(user_id: current_user.id)
    @space_requests_received.reject! do |space|
      space.availabledates.requests.empty?
    end

    erb(:requests)
  end
end
