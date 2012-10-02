require 'spec_helper'
require 'cancan/matchers'

describe Activity do

  describe "an activity" do
    before(:each) do 
      @activity = create(:activity)
    end
    
    it "should allow the user to clock in" do
      time_tracker_count = @activity.time_trackers.count
      @activity.clock_in
      
      @activity.time_trackers.count.should == time_tracker_count + 1
      @activity.time_trackers.last.clock_in.should_not be_nil
    end
    
    it "should allow the user to clock out" do
      @activity.clock_in
      time_tracker_count = @activity.time_trackers.count    
      @activity.clock_out    
      @activity.time_trackers.count.should == time_tracker_count
      @activity.time_trackers.last.clock_out.should_not be_nil
    end
    
    it "should check if the activity is clocked in and not clocked out" do
      @activity.clock_in
      @activity.clocked_in?.should be true
    end
    
    it "should check if the activity is clocked out" do 
      @activity.clock_in
      @activity.clock_out
      @activity.clocked_out?.should be true
    end
    
    it "should check if the activity is clocked in if there are no records" do
      @activity.clocked_in?.should be false
    end
  end
end
