require 'rails_helper'

describe 'badge api', :type => :request do
  before :each do
    @user = create(:user)
    Api::V1::Users::BadgesController.any_instance.stub(:authenticate_request).and_return(@user)
  end 
  describe 'get' do
    it 'can get all user badges' do 
      badge = create(:badge)
      @user.badges << badge
      get "/api/v1/users/#{@user.id}/badges"

      body = JSON.parse(response.body)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(body["data"]["attributes"]["badges"]["data"][0]["attributes"]["name"]).to eq(badge.name)
    end
    it 'errors if incorrect data' do
      get "/api/v1/users/-1/badges"

      body = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(body["error"]).to eq("User not found.")
    end
  end
end
