require 'byebug'

feature 'Requesting a space', js: true, passing: true do
  before(:each) do
    sign_up
    create_space0
    filter_spaces
    click_link TestHelpers::NAME
  end

  scenario 'displays space details after selecting from list of available spaces' do
    expect(page).to have_content(TestHelpers::NAME)
    expect(page).to have_content(TestHelpers::DESCRIPTION)
  end

  scenario 'can select a check in and out date' do
    page.execute_script %{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('2')").trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('3')").trigger("click") }
    expect(page).to have_field('check_in', with: '02-05-2016')
    expect(page).to have_field('check_out', with: '03-05-2016')
  end

  scenario 'adds a request record after selecting valid dates' do
    page.execute_script %{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('2')").trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('3')").trigger("click") }
    click_button('Request booking')
    expect(page).to have_link(TestHelpers::NAME + ': £' + TestHelpers::PRICE)
  end

  scenario 'cannot select an unavailable check in date' do
    page.execute_script %{ $("a.ui-state-default:contains('15')").trigger("click") }
    expect(page).to have_field('check_in', with: '')
  end

  scenario 'cannot select an unavailable check out date' do
    page.execute_script %{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('2')").trigger("click") }
    page.execute_script %{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('4')").trigger("click") }
    expect(page).to have_field('check_in', with: '02-05-2016')
    expect(page).to have_field('check_out', with: '')
  end

  scenario 'cannot select the same date for check in and check out' do
    # page.accept_confirm 'Dates invalid' do
    page.execute_script %{ $('a.ui-datepicker-next').trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('2')").trigger("click") }
    page.execute_script %{ $("a.ui-state-default:contains('2')").trigger("click") }
    click_button('Request booking')
    click_button('OK')
    # end
    expect(page).to have_field('check_in', with: '02-05-2016')
    expect(page).to have_field('check_out', with: '02-05-2016')
  end
end
