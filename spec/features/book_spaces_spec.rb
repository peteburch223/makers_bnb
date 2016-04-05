feature 'Booking spaces' do

  let(:name_content){"Pete's grotty gaff"}
  let(:description_content){"Quite smelly, but nice view"}
  let(:price_content){'99.99'}
  let(:from_date){'03/03/16'}
  let(:to_date){'01/04/16'}

  # let(:name_content2){"Shane's gaff"}
  # let(:description_content2){"Quite pretty, but nice view"}
  # let(:price_content2){'999.99'}

  before(:each) do
    visit 'spaces'
    click_button 'List a Space'
    fill_in('spaceName', with: name_content)
    fill_in('spaceDescription', with: description_content)
    fill_in('spacePrice', with: price_content)
    fill_in('fromDate', with: from_date)
    fill_in('toDate', with: to_date)
    click_button('List my Space')
  end

  scenario 'has fields to add an available date range' do
    fill_in('fromDate', with: from_date)
    fill_in('toDate', with: to_date)
    click_button 'List Spaces'
    expect(page).to have_content(name_content)
  end
end
