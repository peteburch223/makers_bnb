module Emails
  def send_email(to: current_user.email, subject: 'Welcome to MakersBnB',
                 body: 'test body')
    return # COMMENT THIS LINE TO ENABLE EMAILS
    return if ENV['RACK_ENV'] == 'test'
    mail = Mail.new do
      from 'hello@favela.com'
      to       to
      subject  subject
      body     body
    end

    mail.deliver!
  end

  def create_space_email(params)
    from = params[:from_date].split('-').reverse.join('-')
    to = params[:to_date].split('-').reverse.join('-')
    send_email(
      subject: "You've just created a new space: #{params[:name]}",
      body: "Description: #{params[:description]}\nPrice: #{params[:price]}\n"\
      "Available from #{from} to #{to}")
  end

  def booking_confirmation_emails(params, space, requester)
    booking_email_owner(params, space, requester)
    booking_email_requester(params, space, requester)
  end

  def booking_email_owner(params, space, requester)
    approved?(params)
    send_email(
      subject: "You've #{params[:response].downcase} #{requester.email}'s"\
      " request for '#{space.name}'",
      body: @body_owner
    )
  end

  def booking_email_requester(params, space, requester)
    approved?(params)
    send_email(
      to: requester.email,
      subject: "Your request for '#{space.name}' has been"\
      " #{params[:response].downcase}",
      body: @body_requester
    )
  end

  def approved?(params)
    if params[:response] == 'Approved'
      @body_owner = "We hope you enjoy a stranger in your house\n\nKisses"
      @body_requester = "We hope you enjoy staying in a stranger's house\n\n"\
      'Kisses'
    else
      @body_owner = "We're sorry you're too afraid to host that stranger\n\n"\
      'Kisses'
      @body_requester = "We're sorry the stranger didn't like the look of you,"\
      " better luck next time. \n\n Kisses"
    end
  end

  def request_email_requester(space, total_cost)
    send_email(
      to: current_user.email,
      subject: "You've just requested to stay at: #{space.name}",
      body: "#{space.description}\nCost of stay: £#{total_cost}\nKisses")
  end

  def request_email_owner(owner, space, number_of_nights)
    send_email(
      to: owner.email,
      subject: "You have a new request for '#{space.name}'",
      body: "#{current_user.email} has requested to stay in your shithole"\
      " '#{space.name}' for #{number_of_nights} horrific nights!\nKisses")
  end
end
