feature 'List a Space', js: true, passing: true do
  let(:name_content2) { "Shane's gaff" }
  let(:description_content2) { 'Quite pretty, but nice view' }

  before(:each) do
    # sign_up
  end

  scenario 'display ability to book a space' do
    sign_up
    expect(page).to have_content('Book a Space')
  end

  scenario 'first test navigating pages' do
    sign_up

    within('h1') do
      expect(page).to have_content('Book a Space')
    end
  end

  scenario 'single space' do
    sign_up
    create_space0
    filter_spaces
    expect(page).to have_content(TestHelpers::NAME)
    expect(page).to have_content(TestHelpers::DESCRIPTION)
    expect(page).to have_content(TestHelpers::PRICE)

  end

  scenario 'multiple spaces' do
    sign_up
    create_space0
    create_space1
    filter_spaces
    expect(page).to have_content(TestHelpers::NAME)
    expect(page).to have_content(TestHelpers::O1_S1_NAME)
  end
end
