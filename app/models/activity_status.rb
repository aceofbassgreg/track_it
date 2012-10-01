class ActivityStatus
  def initialize(activity_id)
    @time_trackers = TimeTracker.find_all_by_activity_id(activity_id)
    @last = @time_trackers.last || TimeTracker.new
  end
  
  def clocked_in?
    return true if !@last.clock_in.nil?
    return false
  end
  
  def clocked_out?
    return true if !@last.clock_out.nil?
    return false
  end
  
end