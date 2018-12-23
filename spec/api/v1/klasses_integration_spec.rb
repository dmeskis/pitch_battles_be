require 'rails_helper'

describe 'game api', :type => :request do
  describe 'post' do
    it 'can create a class if user is teacher' do
      user = User.new(email: 'teacher@mail.com',
                      password: 'password',
                      password_confirmation: 'password',
                      first_name: 'Bob',
                      last_name: 'Ross',
                      role: 1)
      user.save

      body = {
        email: 'teacher@mail.com',
        password: 'password'
      }

      post '/login', :params => body

      class_body = {
        name: "My class"
      }

      key = JSON.parse(response.body)["access_token"]
      post "/api/v1/classes", :params => class_body, :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(parsed["data"]["attributes"].keys).to contain_exactly("name", "class_key")
      expect(Klass.first.class_key).to eq(parsed["data"]["attributes"]["class_key"])
    end
    it 'cannot create a class if user is not teacher' do
      user = User.new(email: 'teacher@mail.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Bob',
        last_name: 'Ross',
        role: 0)
      user.save

      body = {
      email: 'teacher@mail.com',
      password: 'password'
      }

      post '/login', :params => body

      class_body = {
      name: "My class"
      }

      key = JSON.parse(response.body)["access_token"]
      post "/api/v1/classes", :params => class_body, :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(401)
      expect(parsed["error"]).to eq("You must be a teacher to create a class")
    end
    it 'cannot create a class if no name is provided' do
      user = User.new(email: 'teacher@mail.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Bob',
        last_name: 'Ross',
        role: 1)
      user.save

      body = {
      email: 'teacher@mail.com',
      password: 'password'
      }

      post '/login', :params => body

      key = JSON.parse(response.body)["access_token"]
      post "/api/v1/classes", :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(422)
      expect(parsed["error"]).to eq("You must enter a class name.")
    end
  end
end