

feature 'Signing in' do
  it 'allows a user to sign in' do
    sign_up
    sign_in
    expect(page).to have_content('test@test.com')
  end
end
