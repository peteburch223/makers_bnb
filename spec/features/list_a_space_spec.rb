feature 'Spaces' do

  let(:name_content){"Pete's grotty gaff"}
  let(:description_content){"Quite smelly, but nice view"}
  let(:price_content){'99.99'}

  let(:name_content2){"Shane's gaff"}
  let(:description_content2){"Quite pretty, but nice view"}
  let(:price_content2){'999.99'}

  before(:each) do
    visit '/spaces'
  end

  scenario 'display ability to book a space' do
    expect(page).to have_content('Book a Space')
  end

  scenario 'first test navigating pages' do
    expect(page).to have_content('List a Space')
  end

  scenario 'can list multiple spaces' do

    click_button('List a Space')

    fill_in('spaceName', with: name_content)
    fill_in('spaceDescription', with: description_content)
    fill_in('spacePrice', with: price_content)
    click_button('List my Space')

    click_button('List a Space')
    fill_in('spaceName', with: name_content2)
    fill_in('spaceDescription', with: description_content2)
    fill_in('spacePrice', with: price_content2)
    click_button('List my Space')

    expect(page).to have_content(name_content)
    expect(page).to have_content(description_content)
    expect(page).to have_content(price_content)

    expect(page).to have_content(name_content2)
  end


end
