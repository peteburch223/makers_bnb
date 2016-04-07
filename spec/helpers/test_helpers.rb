module TestHelpers

  O1_USER_EMAIL = "user1@person.com"
  O2_USER_EMAIL = "user2@person.com"
  PASSWORD = "password"

  NAME = "Pete's grotty gaff".freeze
  DESCRIPTION = 'Quite smelly, but nice view'.freeze
  PRICE = '99.99'.freeze
  FROM_DATE = '03/03/2016'.freeze
  TO_DATE = '01/04/2016'.freeze

  O1_S1_NAME = "O1 S1".freeze
  O1_S1_DESCRIPTION = 'O1 S1 Description'.freeze
  O1_S1_PRICE = '99.99'.freeze
  O1_S1_FROM_DATE = '03/03/2016'.freeze
  O1_S1_TO_DATE = '01/04/2016'.freeze

  O1_S2_NAME = "O1 S2".freeze
  O1_S2_DESCRIPTION = 'O2 S2 Description'.freeze
  O1_S2_PRICE = '99.99'.freeze
  O1_S2_FROM_DATE = '03/03/2016'.freeze
  O1_S2_TO_DATE = '01/04/2016'.freeze


  FROM_DATE_MINUS_ONE = '02/03/2016'.freeze
  TO_DATE_PLUS_ONE = '03/04/2016'.freeze
  FROM_DATE_NOT_AVAIL = '03/05/2016'.freeze
  TO_DATE_NOT_AVAIL = '01/06/2016'.freeze
  REQUEST_DATE = '2016-03-05'.freeze

  def sign_up(email: O1_USER_EMAIL,
              password: PASSWORD,
              password_confirmation: PASSWORD)
    visit '/'
    fill_in 'email',    with: email
    fill_in 'password', with: password
    fill_in 'password_confirmation', with: password_confirmation
    click_button 'Sign up'
  end

  def sign_in(email: O1_USER_EMAIL,
              password: PASSWORD)

    visit '/sessions/new'
    fill_in 'email',    with: email
    fill_in 'password', with: password
    click_button 'Log in'
  end

  def log_out
    click_button('Log out')
  end

  def make_request(name: O1_S1_NAME ,date: REQUEST_DATE)
    click_link(name)
    check(date)
    check(REQUEST_DATE)
    click_button 'Request booking'
  end

  def create_multiple_spaces
    click_button('List a Space')
    fill_in('spaceName', with: O1_S1_NAME)
    fill_in('spaceDescription', with: O1_S1_DESCRIPTION)
    fill_in('spacePrice', with: O1_S1_PRICE)
    fill_in('fromDate', with: O1_S1_FROM_DATE)
    fill_in('toDate', with: O1_S1_TO_DATE)
    click_button('List my Space')

    click_button('List a Space')
    fill_in('spaceName', with: O1_S2_NAME)
    fill_in('spaceDescription', with: O1_S2_DESCRIPTION)
    fill_in('spacePrice', with: O1_S2_PRICE)
    fill_in('fromDate', with: O1_S2_FROM_DATE)
    fill_in('toDate', with: O1_S2_TO_DATE)
    click_button('List my Space')
  end


  def make_multiple_requests(s1: O1_S1_NAME, s2: O1_S2_NAME)
    make_request(name: s1)
    visit('/spaces')
    filter_spaces
    make_request(name: s2)

  end




  def create_space(name: O1_S1_NAME,
                   description: DESCRIPTION,
                   price: PRICE,
                   from_date: FROM_DATE,
                   to_date: TO_DATE)

    click_button('List a Space')
    fill_in('spaceName', with: name)
    fill_in('spaceDescription', with: description)
    fill_in('spacePrice', with: price)
    fill_in('fromDate', with: from_date)
    fill_in('toDate', with: to_date)
    click_button('List my Space')
  end

  def filter_spaces(from: FROM_DATE, to: TO_DATE)
    fill_in('fromDate', with: from)
    fill_in('toDate', with: to)
    click_button('List Spaces')
  end
end
