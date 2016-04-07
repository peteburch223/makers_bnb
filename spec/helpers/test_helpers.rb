module TestHelpers
  NAME = "Pete's grotty gaff".freeze
  DESCRIPTION = 'Quite smelly, but nice view'.freeze
  PRICE = '99.99'.freeze
  FROM_DATE = '03/03/2016'.freeze
  TO_DATE = '01/04/2016'.freeze
  FROM_DATE_MINUS_ONE = '02/03/2016'.freeze
  TO_DATE_PLUS_ONE = '03/04/2016'.freeze
  FROM_DATE_NOT_AVAIL = '03/05/2016'.freeze
  TO_DATE_NOT_AVAIL = '01/06/2016'.freeze

  def sign_up(email: 'test@test.com',
              password: 'test1234',
              password_confirmation: 'test1234')
    visit '/'
    fill_in 'email',    with: email
    fill_in 'password', with: password
    fill_in 'password_confirmation', with: password_confirmation
    click_button 'Sign up'
  end

  def sign_in(email: 'test@test.com',
              password: 'test1234')

    visit '/sessions/new'
    fill_in 'email',    with: email
    fill_in 'password', with: password
    click_button 'Log in'
  end

  def create_space(name: NAME,
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
