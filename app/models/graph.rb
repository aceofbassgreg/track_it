class Graph
  def initialize(activity, params)
    @activity = activity
    @start_time = params[:start_time]
    @end_time = params[:end_time]
    @days = params[:days]
  end
  
  def time_frame
    case 
    when (@days.nil? and @start_time.nil? and @end_time.nil?)
      default
    when @days
      standard(@days)
    else
      custom
    end
  end
  
  def default
    standard(7)
  end
  
  def standard(nr)
    @start_time = Time.zone.now - nr.to_i.days
    @end_time = Time.zone.now
  end
  
  def custom
    @start_time = @start_time.to_time.beginning_of_day
    @end_time = @end_time.to_time.end_of_day
  end
  
  
  def good_data?
    return true if @start_time.nil? and @end_time.nil? and @days.nil?
    return true if @days
    return false if @start_time.nil? or @end_time.nil? or @start_time.empty? or @end_time.empty?
    return true if string_to_time?
  end
  
  def string_to_time?
    begin
      @start_time.to_time  
      @end_time.to_time
      true
    rescue ArgumentError
      false
    end
  end
  
#############################################################  

  def all_data
    (empty_data + mapped_data).compact.sort_by {|hash| hash[:date]}
  end
  
  def data
    data = @activity.time_trackers.where(clock_in: @start_time..@end_time).order("clock_in ASC")
    # make sure that the last time trackers is clocked out.
    # if it is not clocked out we can't graph it
    data.pop if !data.empty? and data.last[:clock_out].nil?
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
      array.each { |hash| total_time += (hash[:clock_out] - hash[:clock_in]) / 60 }
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