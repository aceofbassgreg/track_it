class TimeTrackersController < ApplicationController
  def destroy
    @time_tracker = TimeTracker.find(params[:id])
    activity_id = @time_tracker.activity_id
    @time_tracker.destroy
    flash[:notice]="Time tracker destroyed!"
    redirect_to time_trackers_path(activity_id: activity_id)
  end
end
