class UserMailer < ApplicationMailer
  default from: 'noreply@example.com'
  def invite_email(user)
    @user = user
    mail(to: @user.email, subject: 'Invite Link To Group')
  end
  def invite_email_two(inviteuser)
    @inviteuser = inviteuser
    mail(to: @inviteuser.email, subject: 'Invite Link To Group')
  end
end
