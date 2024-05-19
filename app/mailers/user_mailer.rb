class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def invite_shelter(user, shelter_name)
    @user = user
    @shelter_name = shelter_name
    mail(to: @user.email, subject: 'Invitation to Join Our Platform')
  end
end
class UserMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def welcome_email()
  end
end
