class TimeFrame

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
  
end
