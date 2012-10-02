require 'spec_helper'

describe Graph do
  describe "Graph structure" do
    it "raises an error without activity, start and end time" do
      expect{ Graph.new}.to raise_error(ArgumentError)
    end
  
    it "initializez with an activity, a start and an end time" do
      expect{ Grap.new(activity, start_date, end_date)}.to_not raise_error(ArgumentError)
    end
  end
  
  describe "data" do    
    before :all do
      @activity = create(:activity)
      @graph = Graph.new(@activity, Time.now, Time.now)
    end
    
    it "should return a hash" do
      @graph.data.class.should eql(Hash)
    end
    
    it "should have arrays of hashes" do
      create(:time_tracker, activity_id: @activity.id, clock_in: Time.now - 4.hours, clock_out: Time.now - 2.hours)
      create(:time_tracker, activity_id: @activity.id)
      @graph.data[Date.today].class.should eql(Array)
      @graph.data[Date.today].first.serializable_hash.class.should eql(Hash)
    end
    
    describe "collecting data" do 
      it "extracts time trackers between start time and end time" do 
        create(:time_tracker, activity_id: @activity.id)
        @graph.data.size.should eql(1)
      end
  
      it "does NOT extract time trackers before start time" do 
        create(:time_tracker, activity_id: @activity.id, clock_in: Time.now - 10.days, clock_out: Time.now - 10.days)
        @graph.data.size.should eql(0)
      end
  
      it "does NOT extract time trackers after end time" do 
        create(:time_tracker, activity_id: @activity.id, clock_in: Time.now + 10.days, clock_out: Time.now + 10.days)
        @graph.data.size.should eql(0)
      end
    end
  
    describe "processing time" do 
      it "should take one argument" do
        expect{ @graph.time}.to raise_error(ArgumentError)
      end
      
      it "should return a Fixnum" do
        create(:time_tracker, activity_id: @activity.id, clock_out: Time.now + 2.hours)
        create(:time_tracker, activity_id: @activity.id, clock_in: Time.now + 3.hours, clock_out: Time.now + 4.hours)
        @graph.time( @activity.time_trackers).class.should eql(Fixnum)
      end     
    end
  
    describe "mapping data" do 
      it "should map value to total time" do
        create(:time_tracker, activity_id: @activity.id, clock_out: Time.now + 2.hours)
        @graph.mapped_data.first[1].should eql(7200)
      end
    end
  end
end