class TimeTracker < ActiveRecord::Base
  validates_with ClockAbleValidator

  attr_accessible :clock_in, :clock_out, :activity_id, :date
  
  belongs_to :activity
  
  def initialize(attributes = {})
    super
    self.activity_id = activity_id
    self.clock_in = Time.zone.now
    self.date = Date.today
  end
  
end