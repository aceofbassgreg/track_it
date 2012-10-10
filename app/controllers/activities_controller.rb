class ActivitiesController < ApplicationController
  helper_method :graph  
  
  load_and_authorize_resource except: [:create, :update]
  
  def show
    @activity = current_user.activities.find(params[:id])
    @task = Task.new
    @params = params
    if graph.valid?
      graph.time_frame
    else
      flash.now[:error] = "#{graph.errors.messages.first.second[0]}"
      graph.default
    end
  end
  
  def new
    @activity = Activity.new
    @activity_groups = current_user.activity_groups.all
  end
  
  def create
    p "Hello"
    @activity_groups = current_user.activity_groups.all
    
    activity_group_id = params[:activity].delete(:activity_group_id)
    @activity = current_user.activities.new(params[:activity])  
        
    if !activity_group_id.empty?
      @activity.activity_group_id = current_user.activity_groups.find(activity_group_id).id
    else
      @activity.activity_group_id = nil
    end

    authorize! :create, @activity
    if @activity.save
      flash[:notice]= I18n.t "notices.activity.created"
      redirect_to activity_path(@activity)
    else
      flash[:error]= "#{@activity.errors.messages}"
      render 'new'
    end
  end
  
  def edit
    @activity = current_user.activities.find(params[:id])
    @activity_groups = current_user.activity_groups.all
  end
  
  def update
    @activity_groups = current_user.activity_groups.all
    
    activity_group_id = params[:activity].delete(:activity_group_id)
    @activity = current_user.activities.find(params[:id])
    
    if !activity_group_id.empty?
      @activity.activity_group_id = current_user.activity_groups.find(activity_group_id).id
    else
      @activity.activity_group_id = nil
    end
          
    authorize! :update, @activity
    
    if @activity.update_attributes(params[:activity])
      flash[:notice]= I18n.t "notices.activity.updated"
      redirect_to activity_path(@activity)
    else
      flash[:error]= "#{@activity.errors.messages}"
      render 'new'
    end
  end
  
  def destroy
    current_user.activities.find(params[:id]).destroy
    flash[:notice] = I18n.t "notices.activity.destroyed"
    redirect_to activities_path
  end
  
  private 
  
  def graph
      @graph ||= Graph.new(@activity, @params)
  end
end
