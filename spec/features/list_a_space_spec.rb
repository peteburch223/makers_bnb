feature 'Spaces' do
  let(:name_content2) { "Shane's gaff" }
  let(:description_content2) { 'Quite pretty, but nice view' }

  before(:each) do
    visit '/spaces'
  end

  scenario 'display ability to book a space' do
    expect(page).to have_content('Book a Space')
  end

  scenario 'first test navigating pages' do
    expect(page).to have_content('List a Space')
  end

  scenario 'can list multiple spaces' do
    create_space
    create_space(name: name_content2, description: description_content2)
    filter_spaces
    expect(page).to have_content(TestHelpers::NAME)
    expect(page).to have_content(TestHelpers::DESCRIPTION)
    expect(page).to have_content(TestHelpers::PRICE)
    expect(page).to have_content(name_content2)
  end
end
