require 'byebug'

feature 'Requesting a space' do
  before(:each) do
    sign_up
    create_space
    filter_spaces
    click_link TestHelpers::NAME
  end

  scenario 'displays space details after selecting from list of available spaces' do
    expect(page).to have_content(TestHelpers::NAME)
    expect(page).to have_content(TestHelpers::DESCRIPTION)
  end

  scenario 'can select a check in and out date', js: true do
    page.execute_script %{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('2')").trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('3')").trigger("click") }
    expect(page).to have_field('check_in', with: '2016-May-02')
    expect(page).to have_field('check_out', with: '2016-May-03')
  end

  scenario 'adds a request record after selecting valid dates', :js => true do
    page.execute_script %Q{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %Q{ $("a.ui-state-default:contains('2')").trigger("click") }
    page.execute_script %Q{ $("a.ui-state-default:contains('3')").trigger("click") }
    click_button('Request booking')
    expect(page).to have_link(TestHelpers::NAME + ': £' + TestHelpers::PRICE)
  end


  scenario 'cannot select an unavailable check in date', :js => true do
    page.execute_script %Q{ $("a.ui-state-default:contains('15')").trigger("click") }
    expect(page).to have_field('check_in', with: '')
  end

  scenario 'cannot select an unavailable check out date', :js => true do
    page.execute_script %Q{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %Q{ $("a.ui-state-default:contains('2')").trigger("click") }
    page.execute_script %Q{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %Q{ $("a.ui-state-default:contains('4')").trigger("click") }
    expect(page).to have_field('check_in', with: '2016-May-02')
    expect(page).to have_field('check_out', with: '')
  end

  scenario 'cannot select the same date for check in and check out', js: true do
    page.accept_confirm 'Dates invalid' do
      page.execute_script %Q{ $('a.ui-datepicker-next').trigger("click") }
      page.execute_script %Q{ $("a.ui-state-default:contains('2')").trigger("click") }
      page.execute_script %Q{ $("a.ui-state-default:contains('2')").trigger("click") }
      click_button('Request booking')
    end
    expect(page).to have_field('check_in', with: '2016-May-02')
    expect(page).to have_field('check_out', with: '2016-May-02')
  end
end
