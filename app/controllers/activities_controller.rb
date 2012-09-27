class ActivitiesController < ApplicationController
  load_and_authorize_resource
  
  helper_method :status
  
  def index
    @activities = current_user.activities
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
  
  def destroy
    @activity = Activity.find(params[:id])
    @activity.destroy
    flash[:notice] = "Activity destroyed."
    redirect_to activities_path
  end
  
  private

  def graph
    @graph = Graph.new(@activity.id)
  end
  
  def status
    @status = ActivityStatus.new(@activity)
  end
end
