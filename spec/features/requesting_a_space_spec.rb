feature 'requesting a space' do
  before(:each) do
    sign_up
    visit '/spaces'
    click_button('List a Space')
    create_space
  end

  # scenario 'I can navigate the space I want to rent' do
  #   visit 'spaces/6'
  #   expect(page).to have_content(name_content)
  #   expect(page).to have_content(description_content)
  #   expect(page).to have_content(price_content)
  # end
  #
  # scenario 'I can navigate the space I want to rent' do
  #   visit 'spaces/7'
  #   expect(page).to have_content(name_content)
  #   expect(page).to have_content(description_content)
  #   expect(page).to have_content(price_content)
  #
  #   fill_in('From', with: from_date)
  #   fill_in('To', with: to_date)
  #
  #   expect { click_button 'Request booking' }.to change(Request, :count).by(1)
  # end
end
