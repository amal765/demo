class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    authorize @user
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
    if @user.update(user_params)
      render 'show'
    else
      render 'profile_edit'
    end
  end

  def inviter
    authorize @user
    @user = User.find_by(email: params[:user][:email])
    @group = Group.find_by(id: params[:user][:group_id])
    if !@user.present?
      @user = User.new(user_params)
      if @user.save
        display
      else
        error
      end
    else
      display
    end
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :dob, :email, :password, :password_confirmation, :picture, :role_id, :phone_number)
    end

    def role_params
      params.require(:role).permit(:name)
    end

    def group_params
      params.require(:group).permit(:name, :image, :max_members, :group_id, :picture)
    end

  protected

      def display
        reg_object = NewRegistrationService.new({user: @user, group: @group}).limit?
        respond_to do |format|
          if reg_object
            @user = User.find_by(email: params[:user][:email])
            flash[:info] = "Invited Successully"
            format.js {render 'inviter.js.erb'}
          else
            flash[:info] = "Group Limit Reached or User Already present"
            format.js {render 'reload.js.erb'}
          end
        end
      end

      def error
        respond_to do |format|
          format.js {render 'error.js.erb'}
        end
      end
end
