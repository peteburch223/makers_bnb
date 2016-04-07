feature 'Booking spaces', :broken => true do
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

  scenario 'start alignment of date availability range check' do
    filter_spaces(from: TestHelpers::FROM_DATE_MINUS_ONE)
    expect(page).not_to have_content(TestHelpers::NAME)
  end

  scenario 'end alignment of date availability range check' do
    filter_spaces(to: TestHelpers::TO_DATE_PLUS_ONE)
    expect(page).not_to have_content(TestHelpers::NAME)
  end
end
