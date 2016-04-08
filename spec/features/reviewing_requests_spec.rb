feature 'Reviewing requests', js: true, passing: true do
  before(:each) do
    in_browser(:one) do
      sign_up
    end
    in_browser(:two) do
      sign_up(email: TestHelpers::O2_USER_EMAIL)
    end

    in_browser(:one) do
      create_space0
      filter_spaces
    end
  end

  scenario 'displays requests page' do
    in_browser(:one) do
      click_link TestHelpers::NAME
      make_request
      expect(page).to have_content("Requests I've made")
      expect(page).to have_content("Requests I've received")
    end
  end

  scenario 'displays details of request i\'ve made' do
    in_browser(:one) do
      click_link TestHelpers::NAME
      make_request
      expect(page).to have_link(TestHelpers::NAME)
      expect(page).to have_content(Helpers::NOT_CONFIRMED)
      expect(page).to have_content('02/05/2016')
    end
  end

  scenario 'displays details of request i\'ve made multiple bookings' do
    in_browser(:one) do
      visit('/spaces')
      create_space1
      filter_spaces
      click_link TestHelpers::NAME
      make_request
      click_link('Spaces')
      filter_spaces
      click_link TestHelpers::O1_S1_NAME
      make_request
      expect(page).to have_link(TestHelpers::NAME, count: 2)
      expect(page).to have_link(TestHelpers::O1_S1_NAME, count: 2)
    end
  end

  scenario 'displays details of request i\'ve received' do
    in_browser(:two) do
      filter_spaces
      click_link TestHelpers::NAME
      make_request
    end

    in_browser(:one) do
      click_link('Requests')
      expect(page).to have_link(TestHelpers::NAME)
      expect(page).to have_content(Helpers::NOT_CONFIRMED)
    end
  end
end
