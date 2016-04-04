module Helpers

  def sign_up(email: 'test@test.com',
              password: 'test1234',
              password_confirmation: 'test1234')
    visit '/'
    fill_in 'email',    with: email
    fill_in 'password', with: password
    fill_in 'password_confirmation', with: password_confirmation
    click_button 'Sign up'
  end
end
