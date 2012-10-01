class TimeTrackersController < ApplicationController
  def create
    activity = Activity.find(params[:activity_id])
    
    if activity.clock_in
      flash[:notice] = I18n.t "confirmations.activity.clocked_in"
    else
      flash[:error] = I18n.t "activerecord.errors.models.activity.attributes.base.clock_in_able"
    end
    
    redirect_to activity_path(params[:activity_id])
  end
  
  def update
    activity = Activity.find(params[:activity_id])
    
    if activity.clock_out
      flash[:notice] = I18n.t "confirmations.activity.clocked_out"
    else
      flash[:error] = I18n.t "activerecord.errors.models.activity.attributes.base.clock_out_able"
    end
    
    redirect_to activity_path(params[:id])
  end
end