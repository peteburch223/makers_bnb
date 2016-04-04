feature 'Spaces' do

  let(:name_content){"Pete's grotty gaff"}

  scenario 'first test navigating pages' do

    visit '/spaces'
    expect(page).to have_content('Book a Space')
    expect(page).not_to have_content(name_content)
    click_button('List a Space')

    expect(page).to have_content('List a Space')

    fill_in('spaceName', with: name_content)

    click_button('List my Space')
    expect(page).to have_content('Book a Space')
    expect(page).to have_content(name_content)

  end


end
