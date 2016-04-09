feature 'Signing in', js: true, passing: true do
  scenario 'allows a user to sign in' do
    sign_up
    log_out
    sign_in
    expect(page).to have_content(TestHelpers::O1_USER_EMAIL)
  end

  scenario 'does not allow a user to sign in with incorrect password' do
    sign_in(password: 789_101)
    expect(page).to have_content('The email or password is incorrect')
  end

  scenario 'does not allow a user to sign in with incorrect email' do
    sign_in(email: 'twats@email.com')
    expect(page).to have_content('The email or password is incorrect')
  end
end
