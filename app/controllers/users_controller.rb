class UsersController < ApplicationController
  def new
    @user = User.new
  end
  # def index
  #   role_id = current_user.role_id
  #   @role = Role.find(role_id)
  #   @groups = Group.all
  # end

  def show
    @user = User.find(params[:id])
    @role = Role.find(@user.role_id)
  end
  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[ :id])
    @user.update_attributes(user_params)
    redirect_to user_path
  end
  def invite
    @user = User.new
    @group = Group.find(params[:id])
  end

  def inviter

    @user = User.find_by(email: params[:user][:email])
    @group = Group.find_by(id: params[:user][:group_id])
    if @group.users.count(@group.id) < @group.max_members
      if @user.present?
        if !@group.users.find_by(id: @user.id).present?
          @group.users << @user
          UserMailer.invite_email(@user).deliver
          flash[:info] = "Invited Successully"
          redirect_to group_path(@group)
        else
          flash[:info] = "Already Present In Group"
          redirect_to group_path(@group)
        end
      else
        @user = User.new(user_params)
        @user.save(validate: false)
        @group.users << @user
        UserMailer.invite_email_two(@user).deliver
        flash[:info] = "Invited Successully"
        redirect_to group_path(@group)
      end
    else
      flash[:info] = "Group Limit Reached"
      redirect_to group_path(@group)
    end
  end

  def custom_new
    @user = User.find(params[ :id])
  end

  def custom_update

    @user = User.find_by(id: params[:user][:id])
    @user.update_attributes(user_params)
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :dob, :email, :password, :password_confirmation, :picture, :role_id, :phone_number)
    end

    def role_params
      params.require(:role).permit(:name)
    end

    def group_params
      params.require(:group).permit(:name, :image, :max_members)
    end
end
