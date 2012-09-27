class TimeTrackersController < ApplicationController
  
  def create
    @time_tracker = TimeTracker.new(activity_id: params[:activity_id])
    if @time_tracker.save
      flash[:notice]="Clocked in."
      redirect_to activity_path(params[:activity_id])
    else
      flash[:error]=I18n.t "activerecord.errors.models.activity.attributes.base.clock_in_able"
      redirect_to activity_path(params[:activity_id])
    end
  end
  
  def update
    @time_tracker = Activity.find(params[:activity_id]).time_trackers.last
    if @time_tracker.update_attributes(clock_out: Time.zone.now)
      flash[:notice]="Clocked out."
      redirect_to activity_path(params[:id])
    else
      flash[:error]=I18n.t "activerecord.errors.models.activity.attributes.base.clock_out_able"
      redirect_to activity_path(params[:id])
    end
  end
end