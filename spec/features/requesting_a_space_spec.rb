feature 'requesting a space' do
  before(:each) do
    sign_up
    create_space
    filter_spaces
  end



  def make_request(name: TestHelpers::NAME ,date: TestHelpers::REQUEST_DATE)
    click_link(name)
    check(date)
    click_button 'Request booking'
  end


  scenario 'request a booking' do
    click_link TestHelpers::NAME
    expect(page).to have_content(TestHelpers::NAME)
    expect(page).to have_content(TestHelpers::DESCRIPTION)
    check('2016-03-05')

    expect { click_button 'Request booking' }.to change(Request, :count).by(1)
  end

  scenario 'visit requests page (has content)' do
    make_request

    expect(page).to have_content("Requests I've made")
    expect(page).to have_content("Requests I've received")
  end

  scenario 'displays details of request i\'ve made' do
    make_request

    expect(page).to have_link(TestHelpers::NAME)
  end


  #
  # scenario 'I can navigate the space I want to rent' do
  #   visit 'spaces/7'
  #   expect(page).to have_content(name_content)
  #   expect(page).to have_content(description_content)
  #   expect(page).to have_content(price_content)
  #
  #   fill_in('From', with: from_date)
  #   fill_in('To', with: to_date)
  #
  #   expect { click_button 'Request booking' }.to change(Request, :count).by(1)
  # end
end
