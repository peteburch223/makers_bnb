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

  def sign_in(email: 'test@test.com',
              password: 'test1234')
    visit '/sessions/new'
    expect(page).to have_content("Sign in to MakersBnB")
    fill_in 'email',    with: email
    fill_in 'password', with: password
    click_button 'Log in'
  end



end
