class MakersBnB < Sinatra::Base
  get '/payments' do
    erb :payment
  end

  post '/payments/new' do
    Stripe.api_key = 'sk_test_gW9ngr4oHcQm55aRLV4rn3it'

    # Get the credit card details submitted by the form
    token = params[:stripeToken]
    # amount = params[:amount]
    


    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        amount: 1000, # amount in cents, again
        currency: 'gbp',
        source: token,
        description: 'Example charge'
      )
    rescue Stripe::CardError => e
      # The card has been declined
    end
    redirect '/spaces'
  end
end
