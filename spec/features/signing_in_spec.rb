feature 'Signing in', :broken => false  do
  it 'allows a user to sign in' do
    sign_up
    sign_in
    expect(page).to have_content(TestHelpers::O1_USER_EMAIL)
  end

  it 'does not allow a user to sign in with incorrect password' do
    sign_up
    sign_in(password: 789_101)
    expect(page).to have_content('The email or password is incorrect')
  end

  it 'does not allow a user to sign in with incorrect email' do
    sign_up
    sign_in(email: 'twats@email.com')
    expect(page).to have_content('The email or password is incorrect')
  end
end
