class Graph
  
  def initialize(activity, params)
    @activity = activity
    @start_time = params[:start_time]
    @end_time = params[:end_time]
    @days = params[:days]
  end

# selecting the date
##########################################################
  
  def time_frame
    case 
    when params_nil?
      standard(7)
    when @days
      standard(@days)
    when valid_date?
      custom
    else
      standard(7)
    end
  end
  
  def standard(nr)
    @start_time = (Time.zone.now - (nr.to_i - 1).days).beginning_of_day
    @end_time = Time.zone.now.end_of_day
  end
  
  def custom
    @start_time = @start_time.to_time.beginning_of_day
    @end_time = @end_time.to_time.end_of_day
  end
  
  def valid_date?
    return true if params_nil?
    return true if @days
    # start_time and end_time become nil if they are blank
    @start_time = @start_time.to_time.beginning_of_day
    @end_time = @end_time.to_time.end_of_day
    return true if @start_time and @end_time
    rescue ArgumentError
  end
  
  #convenience method
  def invalid_date?
    !valid_date?
  end
  
  def params_nil?
    true if @start_time.nil? and @end_time.nil? and @days.nil?
  end

# generating the date  
#############################################################  
  
  def name
    @activity.title
  end
  
  def year
    @start_time.to_date.strftime("%Y")
  end
  
  def month
    @start_time.to_date.strftime("%m").to_i - 1
  end
  
  def day
    @start_time.to_date.strftime("%d")
  end
  
  def minutes
    minutes = []
    data_hash.each {|key,value| minutes << value}
    minutes
  end

# We collect the data ordered by clock_in in ascending order. We group 
# the data by the date of clock in. And we make sure that if the last
# element is not clocked out it is not included in the graph.  
  
  def collect_data
    data = @activity.time_trackers.where(clock_in: @start_time..@end_time).order("clock_in ASC")
    data.pop if !data.empty? and data.last[:clock_out].nil?
    data.group_by {|hash| hash[:clock_in].to_date}
  end

# We use the time method to calculate the time a user spend on an activity
# in a day and we map that as our new value  
 
  def mapped_data
    data = collect_data
    data.map {|key,value| data[key] = time(value)}
    data
  end
  
  def time(array)
    total_time = 0
      array.each { |hash| total_time += (hash[:clock_out] - hash[:clock_in]) / 60 }
    total_time.to_i
  end
 
  def prepare
    new_hash = {}
    (@start_time.to_date..@end_time.to_date).to_a.each { |value| new_hash["#{value}"] = 0}
    new_hash
  end

# We need to make sure that the key date value has the same format as 
# the other keys otherwise an extra element will pop up
  
  def data_hash
    prepared_data = prepare
    add = mapped_data.each {|key,value| prepared_data[key.strftime('%Y-%m-%d')] = value}
    p "---------"
    p prepared_data.inspect
    prepared_data
  end
end