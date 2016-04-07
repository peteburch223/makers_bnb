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
  end


  scenario 'I can process requests I\'ve received' do
    click_link(TestHelpers::NAME)
    expect(page).to have_content("Request for #{TestHelpers::NAME}")
    expect(page).to have_content("From: #{TestHelpers::O2_USER_EMAIL}")
    expect(page).to have_content("Date: #{TestHelpers::REQUEST_DATE}")

  end

end
