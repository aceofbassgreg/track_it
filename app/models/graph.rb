class Graph

  def initialize(activity, start_time, end_time)
    @activity = activity
    @start_time = start_time.beginning_of_day
    @end_time = end_time.end_of_day
  end
  
  def data
    data = @activity.time_trackers.where(clock_in: @start_time..@end_time).order("clock_in ASC")
    data.group_by {|hash| hash[:clock_in].to_date}
  end
  
  def mapped_data
    new_data = {}
    array = []
    data.each do |key,value| 
      new_data[:date] = key
      new_data[:minutes] = time(value)
      array << new_data
      new_data = {}
    end
    array
  end
  
  def time(array)
    total_time = 0
      array.each { |hash| total_time += hash[:clock_out] - hash[:clock_in] }
    total_time.to_i
  end
end