require 'rails_helper'

RSpec.describe "Admin::Dashboards", type: :request do
  before do
    @admin = User.create!(
      email: "admin@example.com", 
      password: "password", 
      role: :admin, 
      username: "adminuser", 
      location: "Admin City"
    )
  end

  describe "GET /index" do
    it "returns http success" do
      sign_in @admin

      expect(@admin.admin?).to be_truthy

      get "/admin/dashboard/index"
      
      if response.status == 302
        puts "Redirected to: #{response.headers['Location']}"
      end

      expect(response).to have_http_status(:success)
    end
  end
end
