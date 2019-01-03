require 'rails_helper'
require 'helpers/login_helper'
include LoginHelper

describe 'dashboard integration', :type => :request do
  describe 'show' do
    it 'can show a user at the dashboard endpoint' do
      create_student
      login
      user = User.first
      10.times do
        create(:game, user_id: user.id)
      end
      
      key = JSON.parse(response.body)["access_token"]

      get "/api/v1/dashboard", :headers => {'AUTHORIZATION': "bearer #{key}"}
      body = JSON.parse(response.body)
      expect(body["data"]["attributes"]["first_name"]).to eq(user.first_name)
    end
    it 'returns 500 error if user tries to get dashboard without json token' do
      get "/api/v1/dashboard"
      body = JSON.parse(response.body)
      expect(body["message"]).to eq("Nil JSON web token")
    end
  end
end