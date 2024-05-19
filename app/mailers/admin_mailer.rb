class AdminMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def application_pending(user)
    @user = user
    mail(to: 'admin@example.com', subject: 'New User Application Pending')
  end
end
