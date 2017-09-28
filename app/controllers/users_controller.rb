class UsersController < ApplicationController
  def new
    @user = User.new
  end
  def show
    @user = User.find(params[:id])
    @role = @user.role
  end
  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[ :id])
    @user.update_attributes(user_params)
    redirect_to user_path
  end

  def inviter

    @user = User.find_by(email: params[:user][:email])
    @group = Group.find_by(id: params[:user][:group_id])
    respond_to do |format|
      if @group.users.count(@group.id) < @group.max_members
        if @user.present?
          if !@group.users.find_by(id: @user.id).present?
            @group.users << @user
            UserMailer.invite_email(@user).deliver
            flash[:info] = "Invited Successully"
            format.js
          else
            flash[:info] = "Already Present In Group"
          end

        else
          @user = User.new(user_params)
          @user.save(validate: false)
          @group.users << @user
          UserMailer.invite_email_two(@user).deliver
          flash[:info] = "Invited Successully"
          format.js
        end

      else
        flash[:info] = "Group Limit Reached"
      end
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
