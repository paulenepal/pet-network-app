class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def invite_user(user, username)
    @user = user
    @username = username
    @token = @user.raw_invitation_token
    
    subject = "Invitation to Join Our Platform as a #{user.role.capitalize}"
    mail(to: @user.email, subject: subject)
  end

  def welcome_email(user)
    @user = user
    subject = "Your account as #{user.role.capitalize} has been approved"
    mail(to: @user.email, subject: subject)
  end

end