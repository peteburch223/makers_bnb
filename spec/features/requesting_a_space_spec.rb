require 'byebug'

feature 'requesting a space' do
  before(:each) do
    sign_up(email: TestHelpers::O1_USER_EMAIL)
    create_space(name: TestHelpers::O1_S1_NAME)
    filter_spaces
  end

  scenario 'request a booking', :broken => false do
    click_link TestHelpers::O1_S1_NAME
    expect(page).to have_content(TestHelpers::O1_S1_NAME)
    expect(page).to have_content(TestHelpers::DESCRIPTION)
    check('2016-03-05')
    expect { click_button 'Request booking' }.to change(Request, :count).by(1)
  end

  scenario 'visit requests page (has content)', :broken => false do
    make_request

    expect(page).to have_content("Requests I've made")
    expect(page).to have_content("Requests I've received")
  end

  scenario 'displays details of request i\'ve made', :broken => false do
    make_request

    expect(page).to have_link(TestHelpers::O1_S1_NAME)
    expect(page).to have_content(Helpers::NOT_CONFIRMED)
  end

  scenario 'displays details of request i\'ve made multiple bookings', :broken => false do
    create_space(name: TestHelpers::O1_S2_NAME)
    filter_spaces
    # byebug
    make_request(name: TestHelpers::O1_S1_NAME)
    click_link('Spaces')
    filter_spaces
    make_request(name: TestHelpers::O1_S2_NAME)
    expect(page).to have_link(TestHelpers::O1_S1_NAME)
    expect(page).to have_link(TestHelpers::O1_S2_NAME)

  end


  # scenario 'displays details of request i\'ve made multiple bookings to same space' , :broken => false do
  #   create_multiple_spaces
  #   filter_spaces
  #   make_multiple_requests(s1: TestHelpers::O1_S1_NAME, s2: TestHelpers::O1_S1_NAME)
  #   expect(page).to have_link(TestHelpers::O1_S1_NAME, count: 3)
  #
  # end
  #
  #
  # scenario 'displays details of request i\'ve received' , :broken => false do
  #   click_button('Log out')
  #   sign_up(email: TestHelpers::O2_USER_EMAIL)
  #   filter_spaces
  #   make_request
  #   log_out
  #   sign_in
  #   click_link('Requests')
  #   expect(page).to have_link(TestHelpers::NAME)
  #   expect(page).to have_content(Helpers::NOT_CONFIRMED)
  # end
  #
  # scenario 'displays details of multiple requests i\'ve received to same space' , :broken => false do
  #   # byebug
  #
  #   create_space(name: TestHelpers::O1_S2_NAME)
  #   filter_spaces
  #   click_button('Log out')
  #   sign_up(email: TestHelpers::O2_USER_EMAIL)
  #   filter_spaces
  #
  #   make_request(name: TestHelpers::O1_S1_NAME)
  #   make_request(name: TestHelpers::O1_S2_NAME)
  #   log_out
  #   sign_in(email: TestHelpers::O1_USER_EMAIL)
  #   click_link('Requests')
  #   expect(page).to have_link(TestHelpers::O1_S1_NAME, count: 2)
  # end

end
