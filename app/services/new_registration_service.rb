class NewRegistrationService

  def initialize(params)
    @user = params[:user]
    @group = params[:group]
  end

  def limit?
    if (@group.users.count >= @group.max_members) || @group.users.find_by(id: @user.id).present?
      return false
    else
      @group.users << @user
      mailer
      return true
    end
  end

  private

    def mailer
      if @user.activated?
        UserMailer.invite_email(@user).deliver
      else
        UserMailer.invite_email_two(@user).deliver
      end
    end

end
