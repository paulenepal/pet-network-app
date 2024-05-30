require 'rails_helper'

RSpec.describe "Shelter::Pets", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/shelter/pets/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/shelter/pets/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/shelter/pets/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/shelter/pets/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/shelter/pets/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/shelter/pets/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/shelter/pets/destroy"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update_status" do
    it "returns http success" do
      get "/shelter/pets/update_status"
      expect(response).to have_http_status(:success)
    end
  end

end
