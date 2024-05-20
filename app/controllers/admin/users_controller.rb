module Admin
  class UsersController < BaseController
    before_action :set_user, only: [:show, :approve, :deny]

    def index
      @users = User.where.not(id: current_user.id)
    end

    def show
      @adopter = @user.adopter if @user.adopter?
      @shelter = @user.shelter if @user.shelter?
    end

    def approve
      @user.update(approved: true)
      redirect_to admin_users_path, notice: 'User approved.'
    end

    def deny
      @user.destroy
      redirect_to admin_users_path, alert: 'User denied.'
    end

    def invite_shelter_form
    end

    def invite_shelter
      email = params[:email]
      shelter_name = params[:shelter_name]
      user = User.invite!(email: email, role: :shelter) do |u|
        u.skip_invitation = true
        u.username = shelter_name
      end
      UserMailer.invite_shelter(user, shelter_name).deliver_now
      redirect_to admin_dashboard_path, notice: 'Invitation sent.'
    end

    private

    def set_user
      @user = User.find(params[:id])
    end
  end
end
