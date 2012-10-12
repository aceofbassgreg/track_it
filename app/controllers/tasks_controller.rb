class TasksController < ApplicationController
  
  def new
    @task = Task.new
  end
  
  def create
    @activity = current_user.activities.find(params[:activity_id])
    
    unless task = @activity.add_task!(params[:task])
      flash[:error] = I18n.t "errors.task.generic"
      # render or redirect_to
      return
    end
    @task = task
    
    respond_to do |format|
      format.html { redirect_to activity_path(activity) }
      format.js
    end
  end
  
  def update
    activity = current_user.activities.find(params[:activity_id])
    @task = activity.tasks.find(params[:id])
    activity.update_task!(params[:id])
    respond_to do |format|
      format.html { redirect_to activity_path(activity) }
      format.js
    end
  end
  
  def destroy
    activity = current_user.activities.find(params[:activity_id])
    @task = activity.tasks.find(params[:id])
    @task.destroy
    respond_to do |format|
      format.html {redirect_to activity_path(activity)}
      format.js
    end
  end
end
