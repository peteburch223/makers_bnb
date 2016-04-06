feature 'Space availability' do
  before(:each) do
    visit 'spaces'
    create_space
  end

  scenario 'can display a list of available spaces with links to detail page' do
    filter_spaces
    expect(page).to have_link(TestHelpers::NAME)
  end
end
