

feature 'Signing in' do
  it 'allows a user to sign in' do
    sign_up
    sign_in
    expect(page).to have_content('test@test.com')
  end

  it 'allows a user to sign in' do
    sign_up
    sign_in(password: 789101)
    expect(page).to have_content('The email or password is incorrect')
  end



end
