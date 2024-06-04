module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :approve, :deny]

    def index
      @users = User.where.not(id: current_user.id)
      @user = User.all
      @sendbird_app_id = ENV['SENDBIRD_APP_ID']
    end

    def show
      @adopter = @user.adopter if @user.adopter?
      @shelter = @user.shelter if @user.shelter?
    end

    def chat
      @user = User.find(params[:id])
      @username = @user.username
  
      respond_to do |format|
        format.js { render partial: 'chat', locals: { username: @username } }
      end
    end

    def approve
      if @user.update(approved: true)
        UserMailer.welcome_email(@user).deliver_now
        # emjei
        sendbird_controller = Sendbird::SendbirdController.new
        if sendbird_controller.create_user_to_sendbird(@user)
          flash[:notice] = "User registered with Sendbird successfully."
        else
          flash[:alert] = "Error registering user with Sendbird."
        end
        # end emjei
        redirect_to admin_users_path, notice: 'User approved and welcome email sent'
      else
        redirect_to admin_users_path, alert: 'Failed to approve user.'
      end
    end

    def deny
      @user.destroy
      redirect_to admin_users_path, alert: 'User denied.'
    end

    def invite_user_form
    end

    def invite_user
      email = params[:email]
      username = params[:username]
      role = params[:role]
    
      user = User.invite!(email: email, role: role) do |u|
        u.skip_invitation = true
        u.username = username
        u.build_shelter if role == 'shelter'
        u.build_adopter if role == 'adopter'
      end
    
      UserMailer.invite_user(user, username).deliver_now
      redirect_to admin_dashboard_path, notice: 'Invitation sent.'
    end    

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
