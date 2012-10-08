class TimeTrackersController < ApplicationController
  def create
    activity = Activity.find(params[:activity_id])
    
    if activity.clock_in
      flash[:notice] = I18n.t "confirmations.time_tracker.clocked_in"
    else
      flash[:error] = I18n.t "errors.time_tracker.clock_in_able"
    end
    
    redirect_to activity_path(activity)
  end
  
  def update
    activity = Activity.find(params[:activity_id])
    
    if activity.clock_out
      flash[:notice] = I18n.t "confirmations.time_tracker.clocked_out"
    else
      flash[:error] = I18n.t "errors.time_tracker.clock_out_able"
    end
    
    redirect_to activity_path(activity)
  end
end