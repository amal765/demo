class GroupsController < ApplicationController

  def index
    @group = Group.new
    if current_user.admin?
      @groups = Group.all
    else
      @groups = current_user.groups
    end
  end

  def create
    @group = Group.new(group_params)
    authorize @group
    respond_to do |format|
      if @group.save
        format.js
      else
        render 'index'
      end
    end
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users.where.not(id: current_user.id)
    @count = @group.users.count
    @task = Task.new
    @tasks = @group.tasks
    @jobs = current_user.tasks.where(group_id: @group.id)
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
      @user.tasks.destroy_all
      if current_user.admin?
        @users = @group.users
        format.js
      else
        @groups = current_user.groups
        format.js
      end
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
