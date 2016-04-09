feature 'Before Picker requesting a space', js: true, passing: true do
  before(:each) do
    in_browser(:one) do
      sign_up(email: TestHelpers::O1_USER_EMAIL)
      create_space
      create_space1
      create_space2
    end
    in_browser(:two) do
      sign_up(email: TestHelpers::O2_USER_EMAIL)
      filter_spaces
      click_link TestHelpers::NAME
      make_request
      click_link('Spaces')
      filter_spaces
    end
  end

  scenario 'displays details of request i\'ve made multiple bookings' do
    in_browser(:two) do
      click_link TestHelpers::O1_S1_NAME
      make_request
      expect(page).to have_link(TestHelpers::NAME)
      expect(page).to have_link(TestHelpers::O1_S1_NAME)
    end
  end

  scenario 'displays details of request i\'ve made multiple bookings to same space' do
    in_browser(:two) do
      click_link TestHelpers::NAME
      make_request
      expect(page).to have_link(TestHelpers::NAME, count: 2)
    end
  end
end
