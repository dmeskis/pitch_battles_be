require 'rails_helper'

describe 'dashboard integration', :type => :request do
  describe 'show' do
    it 'can show a user at the dashboard endpoint' do
      create_student
      login
      user = User.first
      
      key = JSON.parse(response.body)["access_token"]

      get "/api/v1/dashboard", :headers => {'AUTHORIZATION': "bearer #{key}"}
      body = JSON.parse(response.body)
      expect(body["data"]["attributes"]["first_name"]).to eq(user.first_name)
      User.first.delete
    end
    it 'returns 500 error if user tries to get dashboard without json token' do
      get "/api/v1/dashboard"
      body = JSON.parse(response.body)
      expect(body["message"]).to eq("Nil JSON web token")
    end
  end
end