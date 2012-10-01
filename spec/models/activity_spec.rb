require 'spec_helper'
require 'cancan/matchers'

describe Activity do
  describe "ability" do
    
    before(:each) do 
      @user = create(:user)
      @activity = create(:activity, user_id: @user.id)
      @alien_user = create(:user)
      @alien_activity = create(:activity, user_id: @alien_user.id)
      @ability = Ability.new(@user)
    end
    # 
    # it "allows to read only personal activities" do
    #   @ability.should be_able_to(:read, @activity)   
    # end
    # 
    # it "does NOT allow to read alien activities" do 
    #   @ability.should_not be_able_to(:read, @alien_activity)
    # end
    # 
    # it "allows to destroy personal activities" do
    #   @ability.should be_able_to(:destroy, @activity)
    # end
    # 
    # it "does NOT allow to destroy alien activities" do
    #   @ability.should_not be_able_to(:destroy, @alien_activity)
    # end
    # 
    # it "allows to edit personal activity" do
    #   @ability.should be_able_to(:edit, @activity) 
    # end
    # 
    # it "does NOT allow to edit alien activity" do
    #   @ability.should_not be_able_to(:edit, @activity_alien) 
    # end
    # 
    # it "allows to update personal activity" do
    #   @ability.should be_able_to(:update, @activity) 
    # end
    # 
    # it "does NOT allow to update alien activity" do
    #   @ability.should_not be_able_to(:update, @activity_alien) 
    # end
    # 
    # it "allows to create personal activity" do
    #   @ability.should be_able_to(:create, @activity) 
    # end
    # 
    # it "does NOT allow to create alien activity" do
    #   @ability.should_not be_able_to(:create, @activity_alien) 
    # end
  end
  

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
