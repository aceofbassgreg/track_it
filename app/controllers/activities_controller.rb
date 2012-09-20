class ActivitiesController < ApplicationController
  
  def index
    @activities = Activity.all
  end
  
  def show
    @activity = Activity.find(params[:id])
    
    @time_tracker = TimeTracker.new
    @time_tracker.activity_id = @activity.id
    
    @time_trackers = TimeTracker.find_all_by_activity_id(@activity)
    
    @clock_in = TimeTracker.assign_clock_in_value(params[:id])
    @clock_out = TimeTracker.assign_clock_out_value(params[:id])
  end
  
  def new
    @activity = Activity.new
    @activities = Activity.all
  end
  
  def create
    @activity = Activity.new(params[:activity])
    
    if @activity.save
      flash[:notice]= "New activity created."
      redirect_to activity_path(@activity)
    else
      flash[:error]= "Please check for errors."
      render 'new'
    end
  end
  
  def clock_in
    if TimeTracker.clock_in_able(params[:id])
      TimeTracker.clock_in!(params[:id])
      
      flash[:notice]="Clocked in."
      redirect_to activity_path(params[:id])
    else
      flash[:error]="Make sure you are clocked out first."
      redirect_to activity_path(params[:id])
    end
  end
  
  def clock_out
    if TimeTracker.clock_out_able(params[:id])
      TimeTracker.clock_out!(params[:id])

      flash[:notice]="Clocked out."
      redirect_to activity_path(params[:id])
    else
      flash[:error]="You need to clock in before you can clock out."
      redirect_to activity_path(params[:id])
    end
  end
end
