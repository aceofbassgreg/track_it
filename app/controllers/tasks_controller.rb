class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def create
    activity = current_user.activities.find(params[:activity_id])
    
    flash[:error] = I18n.t "errors.task.generic" if !activity.add_task!(params[:task])    
    
    @task = activity.tasks.last
    
    respond_to do |format|
      format.html { redirect_to activity_path(activity) }
      format.js
    end
  end
  
  def update
    activity = current_user.activities.find(params[:id])
    activity.update_task!(params[:task])
    redirect_to activity_path(activity)
  end
end
