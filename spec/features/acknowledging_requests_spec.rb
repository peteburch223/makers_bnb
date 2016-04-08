require 'byebug'

feature 'Acknowledge bookings', focus: true  do
  before(:each) do
    sign_up(email: TestHelpers::O1_USER_EMAIL)
    create_space
    log_out
    sign_up(email: TestHelpers::O2_USER_EMAIL)
    filter_spaces
    make_request
    log_out
    sign_in(email: TestHelpers::O1_USER_EMAIL)
    visit '/requests'
  end


  scenario 'I can process requests I\'ve received', :interacting => false  do
    click_link(TestHelpers::O1_S1_NAME)
    expect(page).to have_content("Request for #{TestHelpers::O1_S1_NAME}")
    expect(page).to have_content("From: #{TestHelpers::O2_USER_EMAIL}")
    expect(page).to have_content("Date: #{TestHelpers::REQUEST_DATE}")
  end

  scenario 'I can approve request', :interacting => false  do
    click_link(TestHelpers::O1_S1_NAME)
    click_button('Confirm request')
    expect(page).to have_link(TestHelpers::O1_S1_NAME)
    expect(page).not_to have_content(Helpers::NOT_CONFIRMED)
    expect(page).to have_content(Helpers::APPROVED)
  end

  scenario 'I can reject request', :interacting => false  do
    click_link(TestHelpers::O1_S1_NAME)
    click_button('Reject request')
    expect(page).to have_link(TestHelpers::O1_S1_NAME)
    expect(page).not_to have_content(Helpers::NOT_CONFIRMED)
    expect(page).to have_content(Helpers::REJECTED)
  end

end
