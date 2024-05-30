require 'rails_helper'

RSpec.describe "Shelter::AdoptionApplications", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/shelter/adoption_applications/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/shelter/adoption_applications/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/shelter/adoption_applications/update"
      expect(response).to have_http_status(:success)
    end
  end

end
