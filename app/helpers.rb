module Helpers
  NOT_CONFIRMED = 'Not Confirmed'.freeze
  APPROVED = 'Approved'.freeze
  REJECTED = 'Rejected'.freeze

  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  def create_space(params)
    space = Space.create(name: params[:name],
                         description: params[:description],
                         price: params[:price],
                         user_id: current_user.id)

    stay = stay_period(params)
    stay[:nights_count].times do |i|
      Availabledate.create(avail_date: stay[:date_from] + i, space_id: space.id)
    end
    create_space_email(params)
  end

  def available_dates(params)
    stay = stay_period(params)
    create_available_dates stay if stay
  end

  def create_available_dates(stay)
    avail = Hash.new(0)
    stay[:nights_count].times do |i|
      Space.all(availabledates: { avail_date: stay[:date_from] + i }).each do |space|
        avail[space.id] += 1 if Availabledate.all(
          avail_date: stay[:date_from] + i, requests: { status: APPROVED }).empty?
      end
    end
    spaces = []
    avail.each_pair { |k, v| spaces << Space.get(k) if v == stay[:nights_count] }
    spaces
  end

  def stay_period(params)
    return nil unless params[:from_date] && params[:to_date]
    result = {}
    date_from = Date.parse(params[:from_date])
    date_to = Date.parse(params[:to_date])
    nights_count = (date_to - date_from).to_i
    result[:nights_count] = nights_count
    result[:date_from] = date_from
    result
  end

  def make_request(availabledate)
    request_id = Request.max(:request_id)
    request_id = (request_id.nil? ? 1 : request_id + 1)
    number_of_nights = 0
    availabledate.each do |a_date|
      Request.create(user_id: current_user.id,
                     availabledate_id: a_date.id,
                     status: Helpers::NOT_CONFIRMED,
                     request_id: request_id)
      number_of_nights += 1
    end

    space = Space.first(id: availabledate[0].space_id)
    total_cost = space.price.to_f * number_of_nights
    owner = User.first(id: space.user_id)

    request_email_requester(space, total_cost)
    request_email_owner(owner, space, number_of_nights)
  end

  def requests_made
    requests_made = Request.all(
      user_id: current_user.id,
      fields: [:user_id, :request_id], unique: true, order: nil)
    space_requests_made = []
    requests_made.each do |req|
      result = []
      result << Space.first(
        availabledates: { requests: { user_id: current_user.id,
                                      request_id: req.request_id } })
      result << req.request_id
      space_requests_made << result
    end
    prepare_request_display_array(space_requests_made)
  end

  def requests_received
    requests = Request.all
    return [] unless requests
    requests_received = []
    requests.each do |req|
      requests_received << req.request_id if req.availabledate.space.user_id == current_user.id
    end

    requests_received.uniq!
    space_requests_received = []

    requests_received.each do |id|
      result = []
      result << Space.first(availabledates: { requests: { request_id: id } })
      result << id
      space_requests_received << result
    end
    prepare_request_display_array(space_requests_received)
  end

  def prepare_request_display_array(space_request_arrays)
    return [] unless space_request_arrays
    return_value = []
    space_request_arrays.each do |space|
      result = []
      result << space.first
      result << Request.first(request_id: space.last).status
      dates = Availabledate.all(requests: { request_id: space.last })
      result << dates.first.avail_date.strftime(
        '%d/%m/%Y') + ((' - ' + dates.last.avail_date.strftime(
          '%d/%m/%Y') if dates.count > 1) || '')
      result << space.last.to_s
      return_value << result
    end
    return_value
  end
end
