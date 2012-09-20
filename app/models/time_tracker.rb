class TimeTracker < ActiveRecord::Base
  attr_accessible :clock_in, :clock_out, :activity_id
  
  belongs_to :activity
  
  def self.clock_in_able activity_id 
    time_tracker = self.find_all_by_activity_id(activity_id)
    return true if time_tracker.empty?
    return true if time_tracker.last.clock_out != nil
  end
  
  def self.clock_in!(activity_id)
    time_tracker = TimeTracker.new
    time_tracker.clock_in = Time.zone.now
    time_tracker.activity_id = activity_id
    time_tracker.save
  end
    
  def self.clock_out!(activity_id)
    time_tracker = self.find_all_by_activity_id(activity_id).last
    time_tracker.clock_out = Time.zone.now
    time_tracker.save
  end
  

  def self.clock_out_able(activity_id)
    time_tracker = self.find_all_by_activity_id(activity_id)
    return false if time_tracker.size == 0
    return true if time_tracker.last.clock_out == nil
  end
  
  def self.assign_clock_in_value(activity_id)
    time_tracker = self.find_all_by_activity_id(activity_id)
    return "No records yet." if time_tracker.empty?
    return time_tracker.last.clock_in.strftime("%H:%M")
  end
  
  def self.assign_clock_out_value(activity_id)
    time_tracker = self.find_all_by_activity_id(activity_id)
    return " " if time_tracker.empty?
    return "In progress..." if time_tracker.last.clock_out == nil
    return time_tracker.last.clock_out.strftime("%H:%M")
  end
end
