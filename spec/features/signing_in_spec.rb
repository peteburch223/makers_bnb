feature 'Signing in' do
  it 'allows a user to sign in' do
    sign_up
    sign_in
    expect(page).to have_content('test@test.com')
  end

  it 'does not allow a user to sign in with incorrect password' do
    sign_up
    sign_in(password: 789101)
    expect(page).to have_content('The email or password is incorrect')
  end

  it 'does not allow a user to sign in with incorrect email' do
    sign_up
    sign_in(email: 'twats@email.com')
    expect(page).to have_content('The email or password is incorrect')
  end
end
