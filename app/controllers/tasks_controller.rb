class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def create
    activity = Activity.find(params[:activity_id])
    if activity.add_task!(params[:task])
      flash[:notice] = "Task created!"
    else
      flash[:error] = "Make sure your task has a description."
    end
    redirect_to activity_path(activity)
  end
  
  def update
    activity = Activity.find(params[:id])
    flash[:notice] = "Task completed!"
    activity.update_task!(params[:task])
    redirect_to activity_path(params[:id])
  end
end
