require 'spec_helper'

describe Graph do
  
  before :all do 
    @activity = create(:activity)
    @params = {start_time: nil, end_time: nil, days: nil}
  end
  
  describe "structure" do
    it "raises an error without activity and params" do
      expect{ Graph.new}.to raise_error(ArgumentError)
    end
  
    it "initializez with an activity and params" do
      expect{ Grap.new(@activity, @params) }.to_not raise_error(ArgumentError)
    end
  end
  
  describe "validity" do
    
    it "params_nil? should return nil if all attributes are nil" do
      graph = Graph.new(@activity,@params)
      graph.params_nil?.should eql(true)
    end
  end
  
  
end