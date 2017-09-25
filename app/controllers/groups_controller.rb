class GroupsController < ApplicationController

  def new
    @group = Group.new
  end

  def index
    if current_user.admin?
      @groups = Group.all
    else
      @groups = current_user.groups
    end
  end

  def create
    @group = Group.new(group_params)
    authorize @group
    if @group.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @group = Group.find(params[:id])
    @users = @group.users.where.not(id: current_user.id, first_name: nil)
  end

  def destroy
    @group = Group.find(params[:id])
    authorize @group
    @group.destroy
    redirect_to root_path
  end

  def memberdestroy
    @group = Group.find(params[:id])
    @user = User.find(params[:user_id])
    @group.users.delete(@user)
    if current_user.admin?
      redirect_to group_path
    else
      redirect_to root_path
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
