require 'rails_helper'

describe 'user integration', :type => :request do
  describe 'patch' do
    it 'can patch a user' do
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

      patch_body = {              
          first_name: "new_name",
          current_password: "password"
        }

      patch "/api/v1/users/#{User.first.id}", :params => patch_body, :headers => {'AUTHORIZATION': "bearer #{key}"}
      body = JSON.parse(response.body)
      expect(body["data"]["attributes"]["first_name"]).to eq("new_name")
      expect(User.first.first_name).to eq("new_name")
      User.first.delete
    end
    it 'returns 500 error if user tries to patch without json token'
  end
end