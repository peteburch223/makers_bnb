feature 'Reviewing requests' do

  before(:each) do
    sign_up
    create_space0
    filter_spaces
    click_link TestHelpers::NAME
  end

  scenario 'displays requests page', :js => true do
    make_request
    expect(page).to have_content("Requests I've made")
    expect(page).to have_content("Requests I've received")
  end

  scenario 'displays details of request i\'ve made', :js => true do
    make_request
    expect(page).to have_link(TestHelpers::NAME)
    expect(page).to have_content(Helpers::NOT_CONFIRMED)
    expect(page).to have_content('02/05/2016')
    end

  scenario 'displays details of request i\'ve made multiple bookings', :js => true, focus: true do
    visit('/spaces')
    create_space1
    filter_spaces
    click_link (TestHelpers::NAME)
    make_request
    click_link('Spaces')
    filter_spaces
    click_link (TestHelpers::O1_S1_NAME)
    make_request
    expect(page).to have_link(TestHelpers::NAME, count: 2)
    expect(page).to have_link(TestHelpers::O1_S1_NAME, count: 2)
  end

  scenario 'displays details of request i\'ve received', :js => true do
    click_button('Log out')
    sign_up(email: TestHelpers::O2_USER_EMAIL)
    filter_spaces
    click_link TestHelpers::NAME
    make_request
    click_button('Log out')
    sign_in
    click_link('Requests')
    expect(page).to have_link(TestHelpers::NAME)
    expect(page).to have_content(Helpers::NOT_CONFIRMED)
  end
end
