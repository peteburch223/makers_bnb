describe 'Sign up' do

  it 'does not create a user with an empty password' do
    user = User.new(email: 'test@test.com')
    expect(user.save).to be false
  end
end
