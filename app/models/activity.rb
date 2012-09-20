class Activity < ActiveRecord::Base
  attr_accessible :title, :description
  
  has_many :time_trackers
  
end
