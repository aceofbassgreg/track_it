require 'spec_helper'

describe TimeTracker do
  describe "clock able validation" do
    
    error_location = "activerecord.errors.models.activity.attributes.base"
    clock_in_error = I18n.t "#{error_location}.clock_in_able"
    clock_out_error = I18n.t "#{error_location}.clock_out_able"
    either_present_error = I18n.t "#{error_location}.either_present"
    present_error = I18n.t "#{error_location}.present"
  
  before :all do
    @activity = create(:activity)  
  end
  
    it "should not clock out if there are no records in the database" do
      time_tracker = build(:time_tracker,clock_in: nil, activity_id: @activity.id)
      time_tracker.valid?
      time_tracker.errors[:clock_out_able].should include clock_out_error
    end
    
    it "should not clock in if the previous record is not clocked out" do 
      create(:time_tracker,clock_out: nil, activity_id: @activity.id)
      time_tracker = build(:time_tracker, clock_out: nil, activity_id: @activity.id)
      time_tracker.valid?
      time_tracker.errors[:clock_in_able].should include clock_in_error
    end
    
    it "should not clock out if NOT already clocked in" do
      create(:time_tracker)
      time_tracker = build(:time_tracker,clock_in: nil, activity_id: @activity.id)
      time_tracker.valid?
      time_tracker.errors[:clock_out_able].should include clock_out_error
    end
    
    it "should not clock in AND clock out if not already clocked out" do
      create(:time_tracker, clock_out: nil, activity_id: @activity.id)
      time_tracker = build(:time_tracker, activity_id: @activity.id)
      time_tracker.valid?
      time_tracker.errors[:clock_in_able].should include clock_in_error
    end
    
    it "is invalid without both clock in and clock out empty" do 
      time_tracker = build(:time_tracker, clock_in: nil, clock_out: nil, activity_id: @activity.id)
      time_tracker.valid?
      time_tracker.errors[:either_present].should include either_present_error
    end
    
    it "is invalid withouth activity_id" do 
      time_tracker = build(:time_tracker, activity_id: nil)
      time_tracker.valid?
      time_tracker.errors[:present].should include present_error
    end
  end
end
