class Graph

  def initialize(activity, start_time, end_time)
    @activity = activity
    @start_time = start_time.beginning_of_day
    @end_time = end_time.end_of_day
  end
  
  def all_data
    (empty_data + mapped_data).compact.sort_by {|hash| hash[:date]}
  end
  
  def data
    data = @activity.time_trackers.where(clock_in: @start_time..@end_time).order("clock_in ASC")
    # make sure that the last time trackers is clocked out.
    # if it is not clocked out we can't graph it
    data.pop if data.last.clock_out.nil?
    data.group_by {|hash| hash[:clock_in].to_date}
  end
  
  def mapped_data
    array = []
    data.each do |key,value| 
      new_data = {}
      new_data[:date] = key
      new_data[:minutes] = time(value)
      array << new_data
    end
    array
  end
  
  def time(array)
    total_time = 0
      array.each { |hash| total_time += hash[:clock_out] - hash[:clock_in] }
    total_time.to_i
  end
  
  def empty_data
    (@start_time.to_date..@end_time.to_date).to_a.map do |n|
      if not exists?(n)
        hash = {}
        hash[:date] = n
        hash[:minutes] = 0
        hash
      end
    end
  end
  
  def exists?(value)
    boolean = false
    mapped_data.each do |hash|
      boolean = true if hash[:date] == value
    end
    boolean
  end
end