feature 'Space search results', :broken => false do
  before(:each) do
    sign_up
    create_space
  end

  scenario 'can display a list of available spaces with links to detail page' do
    filter_spaces
    expect(page).to have_link(TestHelpers::O1_S1_NAME)
  end
end
