class MakersBnB < Sinatra::Base
  get '/spaces' do
    date_from = Date.parse(params[:from_date]) unless params[:from_date].nil?
    date_to = Date.parse(params[:to_date]) unless params[:to_date].nil?
    @spaces = []
    avail = Hash.new(0)
    if !!date_from && !!date_to
      nights_count = (date_to - date_from).to_i
      nights_count.times do |i|
        Space.all(availabledates: { avail_date: date_from + i }).each do |space|
          avail[space.id] += 1
        end
      end

      avail.each_pair { |k, v| @spaces << Space.get(k) if v == nights_count }
    end
    erb(:spaces)
  end

  get '/spaces/new' do
    erb(:'spaces/new')
  end

  post '/spaces/new' do
    date_from = Date.parse(params[:from_date])
    date_to = Date.parse(params[:to_date])

    nights_count = (date_to - date_from).to_i

    space = Space.create(name: params[:name],
                         description: params[:description],
                         price: params[:price])

    nights_count.times do |i|
      space.availabledates << Availabledate.new(avail_date: date_from + i)
      space.save
    end

    redirect '/spaces'
  end

  get '/spaces/:id' do
    p params[:id]
    @space = Space.get(params[:id].to_i)

    erb(:"spaces/id")
  end
end
