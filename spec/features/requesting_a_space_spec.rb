feature 'requesting a space' do
  before(:each) do
    sign_up
    create_space
    filter_spaces
  end






  scenario 'request a booking' do
    click_link TestHelpers::NAME
    expect(page).to have_content(TestHelpers::NAME)
    expect(page).to have_content(TestHelpers::DESCRIPTION)
    check('2016-03-05')

    expect { click_button 'Request booking' }.to change(Request, :count).by(1)
  end

  scenario 'visit requests page (has content)' do
    make_request

    expect(page).to have_content("Requests I've made")
    expect(page).to have_content("Requests I've received")
  end

  scenario 'displays details of request i\'ve made' do
    make_request

    expect(page).to have_link(TestHelpers::NAME)
  end

  scenario 'displays details of request i\'ve made multiple bookings' do
    create_multiple_spaces
    filter_spaces
    make_multiple_requests
    expect(page).to have_link(TestHelpers::O1_S1_NAME)
    expect(page).to have_link(TestHelpers::O1_S2_NAME)
  end

  scenario 'displays details of request i\'ve received' do

    click_button('Log out')
    sign_up(email: TestHelpers::O2_USER_EMAIL)
    make_request
    click_button('Log out')
    sign_in
    click_link('Requests')
    expect(page).to have_link(TestHelpers::NAME)


  end

end
