class MakersBnB < Sinatra::Base
  post '/requests/new' do
    redirect '/spaces' unless current_user
    redirect '/requests' if params.empty?
    availabledate = []
    ids = params[:availabledate_id].split(',').map(&:to_i)
    ids = [*ids[0]..ids[1]] unless ids.length == 1
    ids.pop unless ids.length == 1
    ids.each { |id| availabledate << Availabledate.get(id) }
    availabledate.each do |a_date|
      p a_date
      Request.create(user_id: current_user.id,
                     availabledate_id: a_date.id,
                     status: Helpers::NOT_CONFIRMED)
    end

    redirect '/requests'
  end

  get '/requests' do
    redirect '/spaces' unless current_user

    # need to ensure that multiple requests to the same space are considered separately
    space_requests_made = Space.all(availabledates: { requests: { user_id: current_user.id } })
    @space_requests_made = prepare_request_display(space_requests_made)

    space_requests_received = Space.all(user_id: current_user.id)
    space_requests_received.reject! { |space| space.availabledates.requests.empty? }
    @space_requests_received = prepare_request_display(space_requests_received)
    erb(:requests)
  end

  def prepare_request_display(requests)
    return_value = []
    requests.each do |space|
      result = []
      result << space
      result << space.availabledates.requests.first.status
      result << space.availabledates.first.avail_date.strftime('%d %m %Y') + (' - ' + space.availabledates.last.avail_date.strftime('%d %m %Y') if space.availabledates.count > 1)
      return_value << result
    end
    return_value
  end
end
