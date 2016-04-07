feature 'Booking spaces', :broken => false do
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
    click_link(TestHelpers::NAME)
  end


  scenario 'I can process requests I\'ve received' do
    expect(page).to have_content("Request for #{TestHelpers::NAME}")
    expect(page).to have_content("From: #{TestHelpers::O2_USER_EMAIL}")
    expect(page).to have_content("Date: #{TestHelpers::REQUEST_DATE}")

  end

  scenario 'I can approve request' do
    click_button('Confirm request')
    expect(page).to have_link(TestHelpers::NAME)
    expect(page).not_to have_content(Helpers::NOT_CONFIRMED)
    expect(page).to have_content(Helpers::APPROVED)
  end

  scenario 'I can reject request' do
    click_button('Reject request')
    expect(page).to have_link(TestHelpers::NAME)
    expect(page).not_to have_content(Helpers::NOT_CONFIRMED)
    expect(page).to have_content(Helpers::REJECTED)
  end

end
