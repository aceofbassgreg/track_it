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
    
    it "allows to read only personal activities" do
      @ability.should be_able_to(:read, @activity)   
    end
    
    it "does NOT allow to read alien activities" do 
      @ability.should_not be_able_to(:read, @alien_activity)
    end
    
    it "allows to destroy personal activities" do
      @ability.should be_able_to(:destroy, @activity)
    end
    
    it "does NOT allow to destroy alien activities" do
      @ability.should_not be_able_to(:destroy, @alien_activity)
    end
    
    it "allows to edit personal activity" do
      @ability.should be_able_to(:edit, @activity) 
    end
    
    it "does NOT allow to edit alien activity" do
      @ability.should_not be_able_to(:edit, @activity_alien) 
    end
    
    it "allows to update personal activity" do
      @ability.should be_able_to(:update, @activity) 
    end
    
    it "does NOT allow to update alien activity" do
      @ability.should_not be_able_to(:update, @activity_alien) 
    end
    
    it "allows to create personal activity" do
      @ability.should be_able_to(:create, @activity) 
    end
    
    it "does NOT allow to create alien activity" do
      @ability.should_not be_able_to(:create, @activity_alien) 
    end
    
    it "allows to clock on a personal activity" do
      @ability.should be_able_to(:clock_in, @activity) 
    end
    
    it "allows to clock on a personal activity" do
      @ability.should be_able_to(:clock_out, @activity) 
    end
    
    it "does NOT allow to clock on an alien activity" do
      @ability.should_not be_able_to(:clock_in, @alien_activity) 
    end
    
    it "does NOT allow to clock on an alien activity" do
      @ability.should_not be_able_to(:clock_out, @alien_activity) 
    end
    
  end
  
end
