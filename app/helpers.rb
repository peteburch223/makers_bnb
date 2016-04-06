module Helpers
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
  end

  def available_dates(params)
    stay = stay_period(params)
    create_available_dates stay if stay
  end

  def create_available_dates(stay)
    spaces = []
    avail = Hash.new(0)
    stay[:nights_count].times do |i|
      Space.all(availabledates: { avail_date: stay[:date_from] + i }).each do |space|
        avail[space.id] += 1
      end
    end

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
end
