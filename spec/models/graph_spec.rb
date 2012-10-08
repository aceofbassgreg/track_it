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
end