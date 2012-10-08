class Graph
  include ActiveModel::Validations
  validates_with GraphDateValidator
  
  attr_accessor :start_time, :end_time, :days
  
  def initialize(activity, params)
    @activity = activity
    @start_time = params[:start_time]
    @end_time = params[:end_time]
    @days = params[:days]
  end

# Selecting a time range. If the user did not get a chance to
# select a time range the it will default to standard(7)
# If the user chose 7, 14 or 30 days then the time_range
# will be one of the standard ranges selected.
# If the user selected a custom range the custom method
# will create the specified range

  def time_frame
    case 
    when params_nil?
      default
    when @days
      standard(@days)
    when custom_dates?
      custom
    end
  end
  
# If the data is valid and the user did not get a chance to 
# select a time range the time range defaults to standard(7)

  def default
    standard(7)
  end  

# Setting the standard time range
    
  def standard(nr)
    @start_time = (Time.zone.now - (nr.to_i - 1).days).beginning_of_day
    @end_time = Time.zone.now.end_of_day
  end

# Setting the custom time range
  
  def custom
    @start_time = @start_time.to_time.beginning_of_day
    @end_time = @end_time.to_time.end_of_day
  end

# If start time or end time are present given that validations passed
# the user selected a custom time range to be represented
  
  def custom_dates?
    true if @start_time
  end

# If start time, end time and days are all nil the page just loaded and 
# the user did't yet select a time range. 
  
  def params_nil?
    true if @start_time.nil? and @end_time.nil? and @days.nil?
  end

# Generating the data content given the selected time_frame 
  
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
 
# We create a hash with all values of zero.
  
  def prepare
    new_hash = {}
    (@start_time.to_date..@end_time.to_date).to_a.each { |value| new_hash["#{value}"] = 0}
    new_hash
  end

# We enter the actual data in a new hash called data_hash
# We need to make sure that the key date value has the same format as 
# the other keys otherwise an extra element will pop up (strftime)...

  def data_hash
    prepared_data = prepare
    add = mapped_data.each {|key,value| prepared_data[key.strftime('%Y-%m-%d')] = value}
    prepared_data
  end
  
# We extract the values from data_hash and place them in an array for 
# highcharts  
  def minutes
    minutes = []
    data_hash.each {|key,value| minutes << value}
    minutes
  end  

# Total time return the time spent on an activity durring the selected
# period of time
  def total_time
    sum = 0
    minutes.collect  {|min| sum += min}.last
    hours = sum / 60
    minutes = sum % 60 
    "#{hours}h #{minutes}m"
  end
  
# We collect the data ordered by clock_in in ascending order. We group 
# the data by the date of clock in. And we make sure that if the last
# element is not clocked out it is not included in the graph.  
  
  def collect_data
    data = @activity.time_trackers.where(clock_in: @start_time..@end_time).order("clock_in ASC")
    data.pop if !data.empty? and data.last[:clock_out].nil?
    data.group_by {|hash| hash[:clock_in].to_date}
  end

# We use the time method to calculate the time a user spends on an activity
# in a day and we map that as our new value  
 
  def mapped_data
    data = collect_data
    data.map {|key,value| data[key] = time_per_day(value)}
    data
  end
  
# Returns the amount of minutes spent on an activity in the given array
# Usually a day
  
  def time_per_day(array)
    total_time = 0
      array.each { |hash| total_time += (hash[:clock_out] - hash[:clock_in]) / 60 }
    total_time.ceil
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
    prepared_data
  end
end