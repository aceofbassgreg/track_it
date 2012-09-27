class Graph
  
  def initialize(date = Date.today, activity_id)
    @date = date
    @activity = Activity.find(activity_id)
  end

  def current_week(day = :sunday)
    @date.beginning_of_week(day)..@date.end_of_week(day)
  end
  
  #store it in the database
  def current_week_daily_time
    array = []
    time_trackers = current_week_time_trackers
    if !time_trackers.empty?
      current_week.map do |day|
        total_day_time = 0
        hash = {}
        #checking to see if a day has time_trackers or not
        if !time_trackers[day].nil? 
          time_trackers[day].each do |time_tracker|
            total_day_time += (time_tracker.clock_out - time_tracker.clock_in)
          end
        end
        hash[:total_time] = (total_day_time/60).round(2)
        hash[:date] = day
        array << hash 
      end
      array
    else
      array
    end
  end
  
  def current_week_time_trackers
    time_trackers = TimeTracker.where(date: current_week, activity_id: @activity.id ).order("clock_in ASC")
    time_trackers.pop if !time_trackers.empty? and time_trackers.last.clock_out.nil?
    time_trackers.group_by(&:date)
  end

end