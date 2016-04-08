feature 'Requesting a space', :broken => false  do
  before(:each) do
    in_browser(:one) do
      sign_up(email: TestHelpers::O1_USER_EMAIL)
      create_space0
      filter_spaces
      click_link TestHelpers::NAME
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
