class UsersController < ApplicationController
    include UsersHelper
  
    def index
      @users = fetch_users_by_role(current_user.role)
    end


  end
  