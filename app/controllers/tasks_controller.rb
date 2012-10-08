class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def create
    activity = Activity.find(params[:activity_id])
    flash[:error] = I18n.t "errors.task.generic" if !activity.add_task!(params[:task])
    redirect_to activity_path(activity)
  end
  
  def update
    activity = Activity.find(params[:id])
    activity.update_task!(params[:task])
    redirect_to activity_path(params[:id])
  end
end
