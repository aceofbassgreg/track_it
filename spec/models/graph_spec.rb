require 'spec_helper'

describe Graph do
  it "raises an error without activity, start and end date" do
    expect{ Graph.new}.to raise_error(ArgumentError)
  end
  
  it "initializez with an activity, a start and an end date" do
    expect{ Grap.new(activity, start_date, end_date)}.to_not raise_error(ArgumentError)
  end
  
  it "extracts time trackers between start date and end date" do 
    activity = create!(:activity)
    create!(:time_tracker,activity_id: activity.id)
    create!(:time_tracker,activity_id: activity.id, clock_in: Time.now.)
  end
end