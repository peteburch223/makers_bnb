require 'spec_helper'

feature 'Signing up' do

  scenario 'user can view the sign up page' do
    visit '/'
    expect(page).to have_content('Sign up to MakersBnB')
  end

  scenario 'user can sign up with valid credentials' do
    visit '/'
    fill_in 'email',    with: 'test@test.com'
    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'password'
    click_button 'Sign up'
  end

  scenario 'user cannot sign up with incorrectly formatted email address' do
    visit '/'
    fill_in 'email',    with: 'test.com'
    fill_in 'password', with: 'password'
    fill_in 'password_confirmation', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content('Email has an invalid format')
  end

end
