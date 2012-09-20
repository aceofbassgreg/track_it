require 'spec_helper'

describe "ManageActivities" do
  
  it "creates an activity and tracks it until clock out" do
    visit new_activity_path
    fill_in 'Title', with: 'test title'
    fill_in 'Description', with: 'test description to see if the process works well'
    click_button 'Create Activity'
    page.should have_content('No records yet.')
    click_link 'Clock in'
    time_regex = /^\d{2}:\d{2}/
    page.text.should match(time_regex)
    page.text.should match('In progress...')
    click_link 'Clock out'
    page.text.should match(time_regex)
    page.text.should_not match('In progress...')
  end
  
  it "allows to manualy change or add time_trackers" do
  end
end
