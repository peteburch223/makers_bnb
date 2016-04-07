feature 'requesting a space', :broken => false  do
  before(:each) do
    in_browser(:one) do
      sign_up(email: TestHelpers::O1_USER_EMAIL)
      create_space(name: TestHelpers::O1_S1_NAME)
      filter_spaces
    end
  end

  scenario 'request a booking' do
    in_browser(:one) do
      click_link TestHelpers::O1_S1_NAME
      expect(page).to have_content(TestHelpers::O1_S1_NAME)
      expect(page).to have_content(TestHelpers::DESCRIPTION)
      check('2016-03-05')
      expect { click_button 'Request booking' }.to change(Request, :count).by(1)
    end
  end

  scenario 'visit requests page (has content)' do
    in_browser(:one) do
      make_request
      expect(page).to have_content("Requests I've made")
      expect(page).to have_content("Requests I've received")
    end
  end

  scenario 'displays details of request i\'ve made' do
    in_browser(:one) do
      make_request
      expect(page).to have_link(TestHelpers::O1_S1_NAME)
      expect(page).to have_content(Helpers::NOT_CONFIRMED)
    end
  end

  scenario 'displays details of request i\'ve made multiple bookings' do
    in_browser(:one) do
      create_space(name: TestHelpers::O1_S2_NAME)
      filter_spaces
      expect(page).to have_link(TestHelpers::O1_S1_NAME)
      expect(page).to have_link(TestHelpers::O1_S2_NAME)
    end
  end

  scenario 'displays details of request i\'ve made multiple bookings to same space' do
    in_browser(:one) do
      create_space(name: TestHelpers::O1_S2_NAME)
      filter_spaces
      make_multiple_requests(s1: TestHelpers::O1_S1_NAME, s2: TestHelpers::O1_S1_NAME)
      expect(page).to have_link(TestHelpers::O1_S1_NAME, count: 2)
    end
  end

end
