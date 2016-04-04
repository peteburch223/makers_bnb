feature 'Spaces' do

  let(:name_content){"Pete's grotty gaff"}
  let(:description_content){"Quite smelly, but nice view"}
  let(:price_content){'99.99'}

  scenario 'first test navigating pages' do

    visit '/spaces'
    expect(page).to have_content('Book a Space')
    expect(page).not_to have_content(name_content)
    click_button('List a Space')

    expect(page).to have_content('List a Space')

    fill_in('spaceName', with: name_content)
    fill_in('spaceDescription', with: description_content)
    fill_in('spacePrice', with: price_content)

    click_button('List my Space')
    expect(page).to have_content('Book a Space')
    expect(page).to have_content(name_content)
    expect(page).to have_content(description_content)
    expect(page).to have_content(price_content)

  end


end
