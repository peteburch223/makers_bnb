feature 'List a Space', :broken => false do
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
    expect(page).to have_content('List a Space')
  end

  scenario 'single space' do
    sign_up
    create_space
    filter_spaces
    expect(page).to have_content(TestHelpers::O1_S1_NAME)
    expect(page).to have_content(TestHelpers::DESCRIPTION)
    expect(page).to have_content(TestHelpers::PRICE)

  end

  scenario 'multiple spaces' do
    sign_up
    create_space
    create_space(name: name_content2, description: description_content2)
    filter_spaces
    expect(page).to have_content(TestHelpers::O1_S1_NAME)
    expect(page).to have_content(name_content2)
  end
end
