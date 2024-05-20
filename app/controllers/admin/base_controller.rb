module Admin
    class BaseController < ApplicationController
      before_action :authenticate_user!
      before_action :ensure_admin
    end
  end
  