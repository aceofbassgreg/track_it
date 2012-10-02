require 'spec_helper'

describe Graph do
  it "raises an error without activity, start and end time" do
    expect{ Graph.new}.to raise_error(ArgumentError)
  end
  
  it "initializez with an activity, a start and an end time" do
    expect{ Grap.new(activity, start_date, end_date)}.to_not raise_error(ArgumentError)
  end
  
  before :all do
    @activity = create(:activity)
  end
  
  it "extracts time trackers between start time and end time" do 
    time_tracker_present = create(:time_tracker,activity_id: @activity.id)
    present = time_tracker_present.clock_in
    graph = Graph.new(@activity, present, present)
    graph.data.size.should eql(1)
  end
  
  it "does NOT extract time trackers before start time" do 
    time_tracker_past = create(:time_tracker,activity_id: @activity.id, clock_in: Time.now - 10.days, clock_out: Time.now - 10.days)
    graph = Graph.new(@activity, Time.now, Time.now)
    graph.data.size.should eql(0)
  end
  
  it "does NOT extract time trackers after end time" do 
    time_tracker_future = create(:time_tracker,activity_id: @activity.id, clock_in: Time.now + 10.days, clock_out: Time.now + 10.days)
    graph = Graph.new(@activity, Time.now, Time.now)
    graph.data.size.should eql(0)
  end
end