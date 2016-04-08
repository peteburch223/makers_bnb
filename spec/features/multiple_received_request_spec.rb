feature 'multiple users multiple requests', passing: true do
  before(:each) do
    in_browser(:one) do
      sign_up(email: TestHelpers::O1_USER_EMAIL)
      create_space0
    end
    in_browser(:two) do
      sign_up(email: TestHelpers::O2_USER_EMAIL)
      filter_spaces
      click_link TestHelpers::NAME
      make_request
      click_link('Spaces')
      filter_spaces
      click_link TestHelpers::NAME
      make_request
    end
  end

  scenario 'displays details of multiple requests i\'ve received to same space', js: true do
    in_browser(:one) do
      click_link('Requests')
      expect(page).to have_content(TestHelpers::NAME, count: 2)
    end
  end
end
