class Adopter::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_adopter

  private

  def ensure_adopter
    unless current_user&.adopter?
      raise User::NotAuthorized, 'Access denied.'
    end
  end

end