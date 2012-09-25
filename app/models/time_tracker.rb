class TimeTracker < ActiveRecord::Base
  validates_with ClockAbleValidator

  attr_accessible :clock_in, :clock_out, :activity_id, :date
  
  belongs_to :activity
  
  def self.format(activity_id, action)
    time_tracker = self.find_all_by_activity_id(activity_id)
    if action == :clock_in
      return "No records yet." if time_tracker.empty?
      return time_tracker.last.clock_in.strftime("%H:%M")
    elsif action == :clock_out
      return " " if time_tracker.empty?
      return "In progress..." if time_tracker.last.clock_out == nil
      return time_tracker.last.clock_out.strftime("%H:%M")
    end
  end
  
  def self.format_time_trackers_table(activity_id)
    time_trackers_values = []
    time_trackers = self.find_all_by_activity_id(activity_id)
    if time_trackers.empty?
      time_trackers_values << ["No records yet."," ","#"]
    else
      last = time_trackers.pop
      if last.clock_out == nil
        time_trackers_values << [last.clock_in.strftime("%H:%M"),"In progress...",last.id]
      else
        time_trackers_values << [last.clock_in.strftime("%H:%M"),last.clock_out.strftime("%H:%M"),last.id]
      end
      
      time_trackers.reverse.each do |time_tracker|
        time_trackers_values << [time_tracker.clock_in.strftime("%H:%M"),time_tracker.clock_out.strftime("%H:%M"),time_tracker.id]
      end
    end
    return time_trackers_values
  end
  
  def self.cumulative_time(date = Date.today)
    week = []
    range = [date.beginning_of_week(start_day = :sunday), date.end_of_week(start_day = :sunday)]
    cum_time = TimeTracker.where(clock_in: range[0]..range[1]).order("clock_in ASC")
  end
end