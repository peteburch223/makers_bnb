class MakersBnB < Sinatra::Base


  get '/spaces' do
    @spaces = Space.all(:availabledates => {:avail_date.gte => params[:from_date], :avail_date.lte => params[:to_date]},
                        :fields => [:name,:description,:price],
                        :order => nil)
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



end
