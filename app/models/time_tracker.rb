class TimeTracker < ActiveRecord::Base
  validates_with ClockAbleValidator

  attr_accessible :clock_in, :clock_out, :activity_id, :date
  
  belongs_to :activity
end
=begin
  #def self.after_create(record)
  def create
    @activity_id = activity_id
    #if self.clock_in.blank?
      self.activity_id = @activity_id
      self.clock_in = Time.zone.now
      self.date = Date.today
    #end
  end
  
  # Update_attributes acts as a clock out for TimeTracker setting the clock_out
  # and making sure time trackers do not extend on multiple days.
  def update_attributes(attributes = {})
    @tomorrow = self.date.tomorrow
    # self.clock_out = Time.zone.now
    # # Split time_tracker if it extends on a different day
    # if not self.date.present?
    #   # clock_out becomes end of the day stored in date
    #   self.clock_out = self.date.end_of_day
    #   # save the first time_tracker
    #   super
    #   # create the second time_tracker
    #   day_split
    # else
    #   super
    # end 
    super
  end
  
  private
  
  # Splits a TimeTracker into two if it extends on two or multiple days. It 
  # informs the user that a time tracker longer then 48 hours is not possible.
  
#   def day_split
#     # Check to see if it is a two day TimeTracker
#     if @tomorrow == Date.today
#       # if it is a two day TimeTracker then add another TimeTracker that ends
#       # at the current time
#       time_tracker = TimeTracker.new(
#         activity_id:  @activity_id,
#         clock_in:     Date.today.beginning_of_day,
#         clock_out:    Time.zone.now,
#         date:         Date.today)
#       time_tracker.save
#     else
#       # if it is not a two day TimeTracker then add another TimeTracker that starts
#       # at the begining of today and ends at the end of today
#       time_tracker = TimeTracker.new(
#         activity_id:  @activity_id,
#         clock_in:     @tomorrow.beginning_of_day,
#         clock_out:    @tomorrow.end_of_day,
#         date:         @tomorrow)
#       time_tracker.save
#     end
#   end
end

#an activity should not extend past two days
#
=end