feature 'Booking spaces' do

  let(:name_content){"Pete's grotty gaff"}
  let(:description_content){"Quite smelly, but nice view"}
  let(:price_content){'99.99'}
  let(:from_date){'03/03/2016'}
  let(:to_date){'01/04/2016'}

  let(:from_date_minus_one){'02/03/2016'}
  let(:to_date_plus_one){'03/04/2016'}


  let(:from_date_not_avail){'03/05/2016'}
  let(:to_date_not_avail){'01/06/2016'}



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

  scenario 'does not display spaces that are unavailable in selected period' do
    fill_in('fromDate', with: from_date_not_avail)
    fill_in('toDate', with: to_date_not_avail)
    click_button('List Spaces')
    expect(page).not_to have_content(name_content)
  end

  scenario 'start alignment of date availability range check' do
    fill_in('fromDate', with: from_date_minus_one)
    fill_in('toDate', with: to_date)
    click_button('List Spaces')
    expect(page).not_to have_content(name_content)
  end
end
