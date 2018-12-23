require 'rails_helper'

describe 'dashboard integration', :type => :request do
  describe 'show' do
    it 'can show a user at the dashboard endpoint' do
      user = User.new(email: 'test@mail.com',
                      password: 'password',
                      password_confirmation: 'password',
                      first_name: 'Bob',
                      last_name: 'Ross',
                      role: 0)
      user.save

      body = {
        email: User.first.email,
        password: 'password'
      }

      post '/login', :params => body

      key = JSON.parse(response.body)["access_token"]

      get "/api/v1/dashboard", :headers => {'AUTHORIZATION': "bearer #{key}"}
      body = JSON.parse(response.body)
      expect(body["data"]["attributes"]["first_name"]).to eq("new_name")
      expect(User.first.first_name).to eq("new_name")
      User.first.delete
    end
    it 'returns 500 error if user tries to get dashboard without json token' do
      user = User.new(email: 'test@mail.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Bob',
        last_name: 'Ross',
        role: 0)
      user.save

      get "/api/v1/dashboard"
      body = JSON.parse(response.body)
      expect(body["message"]).to eq("Nil JSON web token")
    end
  end
end