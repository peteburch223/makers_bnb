feature 'Check access', :focus => false  do
  scenario 'cannot access spaces/new unless logged in' do
    visit '/spaces/new'
    within 'h1' do
      expect(page).not_to have_content 'List a Space'
      expect(page).to have_content 'Book a Space'
    end
  end

  scenario 'cannot create new space from /spaces' do
    visit '/spaces'
    click_button 'List a Space'
    within 'h1' do
      expect(page).not_to have_content 'List a Space'
      expect(page).to have_content 'Book a Space'
    end
  end

  scenario 'cannot create new space from /spaces' do
    visit '/requests'
    within 'h1' do
      expect(page).not_to have_content 'Requests'
      expect(page).to have_content 'Book a Space'
    end
  end
end
