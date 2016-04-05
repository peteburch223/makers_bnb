class MakersBnB < Sinatra::Base

post '/requests/new' do
  p params
  p current_user



  params.each_pair do |k,v|

    Request.create(availabledate_id: v, user_id: current_user.id, status: 'open')

  end

  redirect '/'

  # erb(:'requests')


end


end
