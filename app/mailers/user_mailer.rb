class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def invite_user(user, username)
    @user = user
    @username = username
    @token = @user.raw_invitation_token
    
    subject = "Invitation to Join Our Platform as #{user.role.capitalize}"
    mail(to: @user.email, subject: subject)
  end

  def admin_approval_email(user)
    @user = user
    mail(to: 'admin@email.com', subject: 'New User Signup For Approval')
  end

  def pending_approval_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your Account is Pending Approval')
  end

  def welcome_email(user)
    @user = user
    subject = "Your account as #{user.role.capitalize} has been approved"
    mail(to: @user.email, subject: subject)
  end

end