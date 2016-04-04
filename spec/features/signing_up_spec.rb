require 'spec_helper'

feature 'Signing up' do

  scenario 'user can view the sign up page' do
    visit '/'
    expect(page).to have_content('Sign up to MakersBnB')
  end

  scenario 'user can sign up with valid credentials' do
    expect{ sign_up }.to change(User, :count).by 1
  end

  scenario 'user cannot sign up with incorrectly formatted email address' do
    expect{ sign_up(email: 'test.com') }.not_to change(User, :count)
    expect(page).to have_content('Email has an invalid format')
  end

  scenario 'user cannot sign up with no email address' do
    expect{ sign_up(email: nil) }.not_to change(User, :count)
    expect(page).to have_content('Email must not be blank')
  end

  scenario 'user attempts to sign up with existing email' do
    2.times { sign_up }
    expect(page).to have_content('Email is already taken')
  end

end
