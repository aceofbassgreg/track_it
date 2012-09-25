class ActivitiesController < ApplicationController
  helper_method :status
  
  def index
    @activities = Activity.find_all_by_user_id(current_user.id)
  end
  
  def show
    @activity = Activity.find(params[:id])
    @time_trackers = TimeTracker.find_all_by_activity_id(@activity)
  end
  
  def new
    @activity = Activity.new
    @activities = Activity.all
  end
  
  def create
    @activity = Activity.new(params[:activity])
    @activity.user_id = current_user.id
    
    if @activity.save
      flash[:notice]= "New activity created."
      redirect_to activity_path(@activity)
    else
      flash[:error]= "#{@activity.errors.messages}"
      render 'new'
    end
  end
  
  def edit
    @activity = Activity.find(params[:id])
  end
  
  def update
    @activity = Activity.find(params[:id])
    
    if @activity.save
      flash[:notice]= "Activity updated."
      redirect_to activity_path(@activity)
    else
      flash[:error]= "#{@activity.errors.messages}"
      render 'new'
    end
  end
  
  def clock_in
    @time_tracker = TimeTracker.new
    @time_tracker.clock_in = Time.zone.now
    @time_tracker.date = @time_tracker.clock_in.to_date
    @time_tracker.activity_id = params[:id]
    
    if @time_tracker.save
      flash[:notice]="Clocked in."
      redirect_to activity_path(params[:id])
    else
      flash[:error]=I18n.t "activerecord.errors.models.activity.attributes.base.clock_in_able"
      redirect_to activity_path(params[:id])
    end
  end
  
  def clock_out
    @time_tracker = TimeTracker.find_all_by_activity_id(params[:id]).last || TimeTracker.new # making sure there is a last object
    @time_tracker.clock_out = Time.zone.now
    
    if @time_tracker.save
      flash[:notice]="Clocked out."
      redirect_to activity_path(params[:id])
    else
      flash[:error]=I18n.t "activerecord.errors.models.activity.attributes.base.clock_out_able"
      redirect_to activity_path(params[:id])
    end
  end
  
  private

  def graph
    @graph = Graph.new(@activity.id)
  end
  
  def status
    @status = ActivityStatus.new(@activity.id)
  end
end
