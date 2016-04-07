feature 'Signing out', :broken => true  do
  scenario 'when logged in' do
    sign_up
    click_button 'Log out'
    expect(page).not_to have_content 'test@test.com'
  end

  scenario 'when logged out' do
    visit '/'
    expect(page).not_to have_content 'Log out'
  end
end
