require 'rails_helper'

RSpec.describe "Admin::AdoptionApplications", type: :request do
  let(:admin) { create(:user, :admin, location: 'Admin Location') }
  let(:adopter) { create(:user, :adopter, location: 'Adopter Location') }
  let(:pet) { create(:pet) }
  let!(:adoption_application) { create(:adoption_application, adopter: adopter, pet: pet) }

  before do
    sign_in admin
  end
  describe "GET /index" do
    it "returns http success" do
      get "/admin/adoption_applications/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/admin/adoption_applications/show"
      expect(response).to have_http_status(:success)
    end
  end

end
