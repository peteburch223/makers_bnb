feature 'Space availability' do

  let(:name_content){"Pete's grotty gaff"}
  let(:description_content){"Quite smelly, but nice view"}
  let(:price_content){'99.99'}
  let(:from_date){'03/03/2016'}
  let(:to_date){'01/04/2016'}

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

  scenario 'can display a list of available spaces with links to detail page' do
    fill_in('fromDate', with: from_date)
    fill_in('toDate', with: to_date)
    click_button 'List Spaces'
    expect(page).to have_link(name_content)
  end
end
