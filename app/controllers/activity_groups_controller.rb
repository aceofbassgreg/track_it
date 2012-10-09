class ActivityGroupsController < ApplicationController
  def index
    @activity_groups = ActivityGroup.all_base
  end

  def new
    @activity_group = ActivityGroup.new
  end
  
  def create
    @activity_group = current_user.activity_groups.new(params[:activity_group])
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
    @activity_group = current_user.activity_groups.find(params[:id])
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
end
