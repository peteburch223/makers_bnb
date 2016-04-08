feature 'multiple users multiple requests', :broken => false, :focus => false  do
  before(:each) do
    in_browser(:one) do
      sign_up(email: TestHelpers::O1_USER_EMAIL)
      create_space(name: TestHelpers::O1_S1_NAME)
      filter_spaces
    end
  end

  scenario 'displays details of multiple requests i\'ve received to same space' do
    in_browser(:one) do
      create_space(name: TestHelpers::O1_S2_NAME)
      filter_spaces
    end
    in_browser(:two) do
      sign_up(email: TestHelpers::O2_USER_EMAIL)
      filter_spaces
      make_request(name: TestHelpers::O1_S1_NAME)
      make_request(name: TestHelpers::O1_S1_NAME)
    end
    in_browser(:one) do
      click_link('Requests')
      expect(page).to have_content(TestHelpers::O1_S1_NAME, count: 2)
    end
  end

end
