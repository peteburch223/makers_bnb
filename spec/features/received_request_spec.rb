feature 'multiple users', js: true, passing: true do
  before(:each) do
    in_browser(:one) do
      sign_up(email: TestHelpers::O1_USER_EMAIL)
      create_space1
      filter_spaces
    end
  end

  scenario 'displays details of request i\'ve received' do
    in_browser(:two) do
      sign_up(email: TestHelpers::O2_USER_EMAIL)
      filter_spaces
      click_link(TestHelpers::O1_S1_NAME)
      make_request
    end

    in_browser(:one) do
      click_link('Requests')
      expect(page).to have_link(TestHelpers::O1_S1_NAME)
      expect(page).to have_content(Helpers::NOT_CONFIRMED)
    end
  end
end
