require 'spec_helper'

describe "ManageActivities" do
  
  before (:each) do
    visit new_user_registration_path
    fill_in 'Email', with: 'test@gmail.com'
    fill_in 'Password', with: '1234qwer'
    fill_in 'Password Confirmation', with: '1234qwer'
  end
  
  it "creates an activity, clocks in and clocks out" do
    visit new_activity_path
    fill_in 'Title', with: 'test title'
    fill_in 'Description', with: 'test description to see if the process works well'
    click_button 'Create Activity'
    page.should have_content('No records yet.')
    click_link 'Clock in'
    time_regex = /^\d{2}:\d{2}/ #testing for presence of time Examples: 08:20, 12:13, 17:80
    page.text.should match(time_regex)
    page.text.should match('In progress...')
    click_link 'Clock out'
    page.text.should match(time_regex)
    page.text.should_not match('In progress...')
  end
end
