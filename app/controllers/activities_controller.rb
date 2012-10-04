class ActivitiesController < ApplicationController
  helper_method :graph
  
  load_and_authorize_resource
  
  def index
    @activities = current_user.activities
  end
  
  def show
    @activity = current_user.activities.find(params[:id])
    if graph.good_data?(params)
      graph.time_frame(params)
    else
      flash.now[:error] = "Please enter valid data."
      graph.default
    end
  end
  
  def new
    @activity = current_user.activities.new
  end
  
  def create
    @activity = current_user.activities.new(params[:activity])   
    if @activity.save
      flash[:notice]= "New activity created."
      redirect_to activity_path(@activity)
    else
      flash[:error]= "#{@activity.errors.messages}"
      render 'new'
    end
  end
  
  def edit
    @activity = current_user.activities.find(params[:id])
  end
  
  def update
    @activity = current_user.activities.find(params[:id])  
    if @activity.save
      flash[:notice]= "Activity updated."
      redirect_to activity_path(@activity)
    else
      flash[:error]= "#{@activity.errors.messages}"
      render 'new'
    end
  end
  
  def destroy
    current_user.activities.find(params[:id]).destroy
    flash[:notice] = "Activity destroyed."
    redirect_to activities_path
  end
  
  private 
  
  def graph
      @graph ||= Graph.new(@activity)
  end
end
