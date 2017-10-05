class GroupsController < ApplicationController

  def index
    @group = Group.new
    if current_user.admin?
      @groups = Group.all
    else
      @groups = current_user.groups
    end
  end

  def new
  end
  def create
    @group = Group.new(group_params)
    authorize @group
    respond_to do |format|
      if @group.save
        format.js
      else
        format.js {render 'reload.js.erb'}
      end
    end
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users.where.not(id: current_user.id)
    @task = Task.new
    @user = User.new
    @tasks = @group.tasks
    @jobs = @tasks.where(user_id: current_user.id)
  end

  def destroy
    @group = Group.find(params[:id])
    authorize @group
    respond_to do |format|
      if @group.destroy
        @groups = Group.all
        format.js
      end
    end
  end

  def member_destroy
    @group = Group.find(params[:id])
    @user = User.find(params[:user_id])
    respond_to do |format|
      @group.users.delete(@user)
      @user.tasks.where(group_id: @group.id).destroy_all
      @groups = current_user.groups
      @users = @group.users
      format.js
    end
  end

  def delete_modal

    respond_to do |format|
      @group = Group.find(params[:id])
      format.js
    end
  end

  private

    def group_params
      params.require(:group).permit(:name, :image, :max_members)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :dob, :email, :password, :password_confirmation, :picture)
    end
end
