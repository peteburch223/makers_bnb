feature 'Acknowledge bookings', passing: true do
  before(:each) do
    in_browser(:one) do
      sign_up(email: TestHelpers::O1_USER_EMAIL)
      create_space
    end
    in_browser(:two) do
      sign_up(email: TestHelpers::O2_USER_EMAIL)
      filter_spaces
      click_link TestHelpers::NAME
      make_request
    end

    in_browser(:one) do
      visit '/requests'
      click_link(TestHelpers::NAME)
    end
  end

  scenario 'I can process requests I\'ve received', js: true do
    in_browser(:one) do
      expect(page).to have_content("Request for #{TestHelpers::NAME}")
      expect(page).to have_content("From: #{TestHelpers::O2_USER_EMAIL}")
    end
  end

  scenario 'I can approve request', js: true do
    in_browser(:one) do
      click_button('Confirm request')
      expect(page).to have_link(TestHelpers::NAME)
      expect(page).not_to have_content(Helpers::NOT_CONFIRMED)
      expect(page).to have_content(Helpers::APPROVED)
    end
  end

  scenario 'I can reject request', js: true do
    in_browser(:one) do
      click_button('Reject request')
      expect(page).to have_link(TestHelpers::NAME)
      expect(page).not_to have_content(Helpers::NOT_CONFIRMED)
      expect(page).to have_content(Helpers::REJECTED)
    end
  end
end
