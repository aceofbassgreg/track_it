require 'spec_helper'

describe TimeTracker do
  describe "clock able validation" do
    
    error_location = "activerecord.errors.models.activity.attributes.base"
    clock_in_error = I18n.t "#{error_location}.clock_in_able"
    clock_out_error = I18n.t "#{error_location}.clock_out_able"
    presence_error = I18n.t "#{error_location}.presence"
    
    it "should not clock out if there are no records in the database" do
      time_tracker = build(:time_tracker,clock_out: Time.now)
      time_tracker.valid?
      time_tracker.errors[:clock_out_able].should include clock_out_error
    end
    
    it "should not clock in if the previous record is not clocked out" do 
      create(:time_tracker,clock_in: Time.now)
      time_tracker = build(:time_tracker,clock_in: Time.now)
      time_tracker.valid?
      time_tracker.errors[:clock_in_able].should include clock_in_error
    end
    
    it "should not clock out if NOT already clocked in" do
      create(:time_tracker,clock_in: Time.now, clock_out: Time.now + 1)
      time_tracker = build(:time_tracker, clock_out: Time.now + 2)
      time_tracker.valid?
      time_tracker.errors[:clock_out_able].should include clock_out_error
    end
    
    it "should not clock in AND clock out if not already clocked out" do
      create(:time_tracker,clock_in: Time.now)
      time_tracker = build(:time_tracker, clock_in: Time.now, clock_out: Time.now + 1)
      time_tracker.valid?
      time_tracker.errors[:clock_in_able].should include clock_in_error
    end
  
    # slightly modified presence validator
    it "should not save empty record" do 
      time_tracker = build(:time_tracker)
      time_tracker.valid?
      time_tracker.errors[:presence].should include presence_error
    end
  end
end
