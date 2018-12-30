require 'rails_helper'
require 'helpers/login_helper'
include LoginHelper

describe 'user integration', :type => :request do
  describe 'patch' do
    it 'can patch a user' do
      create_student
      login

      key = JSON.parse(response.body)["access_token"]

      patch_body = {              
          first_name: "new_name",
          current_password: "password"
        }

      patch "/api/v1/users", :params => patch_body, :headers => {'AUTHORIZATION': "bearer #{key}"}
      body = JSON.parse(response.body)
      expect(body["data"]["attributes"]["first_name"]).to eq("new_name")
      expect(User.first.first_name).to eq("new_name")
      User.first.delete
    end
    it 'returns 500 error if user tries to patch without json token' do
      create_student

      patch_body = {              
      first_name: "new_name",
      current_password: "password"
      }

      patch "/api/v1/users", :params => patch_body
      body = JSON.parse(response.body)
      expect(body["message"]).to eq("Nil JSON web token")
    end
  end
end