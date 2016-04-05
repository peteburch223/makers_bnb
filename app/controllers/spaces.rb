class MakersBnB < Sinatra::Base


  get '/spaces' do
    @spaces = Space.all(:availabledates.gte => params[:from_date],
                        :availabledates.lte => params[:to_date],
                        :fields => [:name,:description,:price],
                        :order => nil)
    erb(:spaces)
  end

  get '/spaces/new' do
    erb(:'spaces/new')
  end

  post '/spaces/new' do
    Space.create(name: params[:name],
                 description: params[:description],
                 price: params[:price])
    redirect '/spaces'
  end

end
