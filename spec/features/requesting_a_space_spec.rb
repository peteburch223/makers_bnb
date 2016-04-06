feature 'requesting a space' do
  let(:name_content) { "Pete's grotty gaff" }
  let(:description_content) { 'Quite smelly, but nice view' }
  let(:price_content) { '99.99' }
  let(:from_date) { '03/03/2016' }
  let(:to_date) { '01/04/2016' }

  let(:name_content2) { "Shane's gaff" }
  let(:description_content2) { 'Quite pretty, but nice view' }
  let(:price_content2) { '999.99' }

  before(:each) do
    sign_up
    visit '/spaces'
    click_button('List a Space')
    # PLEASE MAKE A HELPER METHOD FOR THIS
    fill_in('spaceName', with: name_content)
    fill_in('spaceDescription', with: description_content)
    fill_in('spacePrice', with: price_content)
    fill_in('fromDate', with: from_date)
    fill_in('toDate', with: to_date)
    click_button('List my Space')
  end

  scenario 'I can navigate the space I want to rent' do
    visit 'spaces/6'
    expect(page).to have_content(name_content)
    expect(page).to have_content(description_content)
    expect(page).to have_content(price_content)
  end

  scenario 'I can navigate the space I want to rent' do
    visit 'spaces/7'
    expect(page).to have_content(name_content)
    expect(page).to have_content(description_content)
    expect(page).to have_content(price_content)

    fill_in('From', with: from_date)
    fill_in('To', with: to_date)

    expect { click_button 'Request booking' }.to change(Request, :count).by(1)
  end
end
