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

  def profile_edit
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
      if !@user.present?
        @user = User.new(user_params)
        if @user.save
          display
        else
          format.js {render 'error.js.erb'}
        end
      else
        display
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
      params.require(:group).permit(:name, :image, :max_members, :group_id)
    end

  protected

      def display
        reg_object = NewRegistrationService.new({user: @user, group: @group}).limit?
        if reg_object
          @user = User.find_by(email: params[:user][:email])
          format.js {render 'inviter.js.erb'}
          flash[:info] = "Invited Successully"
        else
          flash[:info] = "Group Limit Reached or User Already present"
          format.js {render 'reload.js.erb'}
        end
      end
end
