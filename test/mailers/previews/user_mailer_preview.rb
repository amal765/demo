# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
  def invite_email
     @user = User.first
    UserMailer.invite_email(@user)
  end
  def invite_email_two
    @user = User.first
    @group = Group.first
    UserMailer.invite_email_two(@user,@group)
  end
end
