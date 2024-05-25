class ApplicationMailer < ActionMailer::Base
  default from: "from@example.com"
  layout "mailer"

  include Rails.application.routes.url_helpers
  include Devise::Controllers::UrlHelpers

  def default_url_options
    Rails.application.config.action_mailer.default_url_options
  end
end