module TestHelpers
  O1_USER_EMAIL = 'user1@person.com'.freeze
  O2_USER_EMAIL = 'user2@person.com'.freeze
  PASSWORD = 'password'.freeze

  NAME = 'Space 0'.freeze
  DESCRIPTION = 'Space 0 description'.freeze
  PRICE = '100.00'.freeze
  FROM_DATE = '01/05/2016'.freeze
  TO_DATE = '31/05/2016'.freeze

  O1_S1_NAME = 'Space 1'.freeze
  O1_S1_DESCRIPTION = 'Space 1 description'.freeze
  O1_S1_PRICE = '99.99'.freeze
  O1_S1_FROM_DATE = '01/05/2016'.freeze
  O1_S1_TO_DATE = '31/05/2016'.freeze

  O1_S2_NAME = 'Space 2'.freeze
  O1_S2_DESCRIPTION = 'Space 2 description'.freeze
  O1_S2_PRICE = '99.99'.freeze
  O1_S2_FROM_DATE = '01/05/2016'.freeze
  O1_S2_TO_DATE = '31/05/2016'.freeze

  FROM_DATE_MINUS_ONE = '30/04/2016'.freeze
  TO_DATE_PLUS_ONE = '01/06/2016'.freeze
  FROM_DATE_NOT_AVAIL = '01/06/2016'.freeze
  TO_DATE_NOT_AVAIL = '30/06/2016'.freeze
  REQUEST_DATE = '2016-05-15'.freeze


  def in_browser(name)
    old_session = Capybara.session_name
    Capybara.session_name = name
    yield
    Capybara.session_name = old_session
  end

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

  def create_space0
    click_button('List a Space')
    fill_in('spaceName', with: NAME)
    fill_in('spaceDescription', with: DESCRIPTION)
    fill_in('spacePrice', with: PRICE)
    fill_in('fromDate', with: FROM_DATE)
    fill_in('toDate', with: TO_DATE)
    click_button('List my Space')
  end

  def create_space1
    click_button('List a Space')
    fill_in('spaceName', with: O1_S1_NAME)
    fill_in('spaceDescription', with: O1_S1_DESCRIPTION)
    fill_in('spacePrice', with: O1_S1_PRICE)
    fill_in('fromDate', with: O1_S1_FROM_DATE)
    fill_in('toDate', with: O1_S1_TO_DATE)
    click_button('List my Space')
  end

  def create_space2
    click_button('List a Space')
    fill_in('spaceName', with: O1_S2_NAME)
    fill_in('spaceDescription', with: O1_S2_DESCRIPTION)
    fill_in('spacePrice', with: O1_S2_PRICE)
    fill_in('fromDate', with: O1_S2_FROM_DATE)
    fill_in('toDate', with: O1_S2_TO_DATE)
    click_button('List my Space')
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

  def make_request(name: TestHelpers::NAME)
    page.execute_script %Q{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %Q{ $("a.ui-state-default:contains('2')").trigger("click") }
    page.execute_script %Q{ $("a.ui-state-default:contains('3')").trigger("click") }
    click_button('Request booking')
  end

#   def create_space(name: O1_S1_NAME,
#                    description: DESCRIPTION,
#                    price: PRICE,
#                    from_date: FROM_DATE,
#                    to_date: TO_DATE)
#
#     click_button('List a Space')
#     fill_in('spaceName', with: name)
#     fill_in('spaceDescription', with: description)
#     fill_in('spacePrice', with: price)
#     fill_in('fromDate', with: from_date)
#     fill_in('toDate', with: to_date)
#     click_button('List my Space')
# end

  def make_multiple_requests
    filter_spaces
    click_link 'Space 1'
    make_request(name: NAME)
    visit('/spaces')
    filter_spaces
    click_link 'Space 2'
    make_request(name: O1_S1_NAME)
  end

  def filter_spaces(from: FROM_DATE, to: TO_DATE)
    fill_in('fromDate', with: from)
    fill_in('toDate', with: to)
    click_button('List Spaces')
  end
end
