feature 'Spaces' do


  scenario 'first test navigating pages' do

    visit '/spaces'
    expect(page).to have_content('Book a Space')
    click_button('List a Space')

    expect(page).to have_content('List a Space')

    click_button('List my Space')
    expect(page).to have_content('Book a Space')

  end


end
