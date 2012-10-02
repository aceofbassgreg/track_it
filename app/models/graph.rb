class Graph

  def initialize(activity, start_time, end_time)
    @activity = activity
    @start_time = start_time.beginning_of_day
    @end_time = end_time.end_of_day
  end
  
  def data
    @activity.time_trackers.where(clock_in: @start_time..@end_time)
  end
end