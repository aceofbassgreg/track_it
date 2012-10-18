class ActivityGroupsController < ApplicationController
  load_and_authorize_resource except: [:create, :update]

  helper_method :activity_groups
  def index
    @activity_groups = current_user.activity_groups.all_base
    @activities_base = current_user.activities.all_base
    @activity_group = current_user.activity_groups.new
    @activity = current_user.activities.new
    @activities = current_user.activities.all
  end

  def show
    @activity_group = current_user.activity_groups.find(params[:id])
    @activities = @activity_group.activities.all
  end

  def new
    @activity_group = ActivityGroup.new
  end
  
  def create
    activity_group_id = params[:activity_group].delete(:activity_group_id)
    @activity_group = current_user.activity_groups.new(params[:activity_group]) 
    if !activity_group_id.empty?
      @activity_group.activity_group_id = current_user.activity_groups.find(activity_group_id).id
    else
      @activity_group.activity_group_id = nil
    end
    authorize! :create, @activity_group
    if @activity_group.save
      flash[:notice] = I18n.t "notices.activity_group.created"
      redirect_to activity_groups_path
    else 
      flash[:error] = "#{@activity_group.errors.messages}"
      render 'new'
    end
  end

  def edit
    @activity_group = current_user.activity_groups.find(params[:id])
  end
  
  def update
    activity_group_id = params[:activity_group].delete(:activity_group_id)
    @activity_group = current_user.activity_groups.find(params[:id])
    if !activity_group_id.empty?
      @activity_group.activity_group_id = current_user.activity_groups.find(activity_group_id).id
    else 
      @activity_group.activity_group_id = nil
    end
    authorize! :update, @activity_group
    if @activity_group.update_attributes(params[:activity_group])
      flash[:notice] = I18n.t "notices.activity_group.updated"
    else
      flash[:error] = "#{activity_group.errors.messages}"
    end
    redirect_to activity_groups_path
  end
  
  def destroy
    current_user.activity_groups.find(params[:id]).destroy
    flash[:notice] = I18n.t "notices.activity_group.destroyed"
    redirect_to activity_groups_path
  end

  private

  def activity_groups
    @activity_groups ||= current_user.activity_groups.all
  end
end
