module ShelterNamespace
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :ensure_shelter

    private

    def ensure_shelter


      unless current_user&.shelter?
        redirect_to root_path, alert: 'Access denied.'
      end
    end
  end
end
