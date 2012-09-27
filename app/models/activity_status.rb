class ActivityStatus
  def initialize(activity)
    @time_tracker = activity.time_trackers.last
  end
  
  def clocked_in?
    return true unless @time_tracker.blank? or @time_tracker.clock_in.blank?
  end
  
  def clocked_out?
    return true unless @time_tracker.blank? or @time_tracker.clock_out.blank?
  end
  
end