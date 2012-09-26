class TimeTracker < ActiveRecord::Base
  validates_with ClockAbleValidator

  attr_accessible :clock_in, :clock_out, :activity_id, :date
  
  belongs_to :activity
  
end