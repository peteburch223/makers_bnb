feature 'booked space not available', js: true, passing: true do
  before(:each) do
    in_browser(:one) do
      sign_up(email: TestHelpers::O1_USER_EMAIL)
    end
    in_browser(:two) do
      sign_up(email: TestHelpers::O2_USER_EMAIL)
    end
  end

  scenario 'book space for one day - not shown in filter' do
    in_browser(:one) do
      create_space2
    end

    in_browser(:two) do
      filter_spaces(from: TestHelpers::O1_S2_FROM_DATE, to: TestHelpers::O1_S2_TO_DATE)
      click_link TestHelpers::O1_S2_NAME
      make_request
    end

    in_browser(:one) do
      visit '/requests'
      click_link(TestHelpers::O1_S2_NAME)
      click_button('Confirm request')
    end

    in_browser(:two) do
      click_link('Spaces')
      filter_spaces(from: TestHelpers::O1_S2_FROM_DATE, to: TestHelpers::O1_S2_TO_DATE)
      expect(page).not_to have_content(TestHelpers::O1_S2_NAME)
    end
  end

  scenario 'booked dates not available in date picker'  do
    in_browser(:one) do
      create_space1
    end

    in_browser(:two) do
      filter_spaces(from: TestHelpers::O1_S1_FROM_DATE, to: TestHelpers::O1_S1_TO_DATE)
      click_link TestHelpers::O1_S1_NAME
      make_request
    end

    in_browser(:one) do
      visit '/requests'
      click_link(TestHelpers::O1_S1_NAME)
      click_button('Confirm request')
    end

    in_browser(:two) do
      click_link('Spaces')
      filter_spaces(from: TestHelpers::FROM_DATE_EXCL_RES, to: TestHelpers::TO_DATE_EXCL_RES)
      click_link TestHelpers::O1_S1_NAME
    end
  end
end
