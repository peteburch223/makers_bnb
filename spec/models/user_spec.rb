describe 'Sign up' do

  it 'does not create a user with an empty password' do
    user = User.new(email: 'test@test.com')
    expect(user.save).to be false
  end

  it 'does not create a user with an empty password' do
    user = User.new(email: 'test@test.com',password: "123456", password_confirmation: "123456")    
    expect(user.save).to be true
  end


end
