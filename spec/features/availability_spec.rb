require 'byebug'

feature 'Searching availability', js: true, passing: true do
  before(:each) do
    sign_up
    create_space
  end

  scenario 'has fields to add an available date range' do
    filter_spaces
    expect(page).to have_content(TestHelpers::NAME)
  end

  scenario 'does not display spaces that are unavailable in selected period' do
    filter_spaces(from: TestHelpers::FROM_DATE_NOT_AVAIL,
                  to: TestHelpers::TO_DATE_NOT_AVAIL)
    expect(page).not_to have_content(TestHelpers::NAME)
  end

  scenario 'does not show a space when from date is unavailable' do
    filter_spaces(from: TestHelpers::FROM_DATE_MINUS_ONE)
    expect(page).not_to have_content(TestHelpers::NAME)
  end

  scenario 'does not show a space when to date is unavailable' do
    filter_spaces(to: TestHelpers::TO_DATE_PLUS_ONE)
    expect(page).not_to have_content(TestHelpers::NAME)
  end

  scenario 'can display a list of available spaces with links to detail page' do
    filter_spaces
    # byebug
    expect(page).to have_link(TestHelpers::NAME)
  end
end
