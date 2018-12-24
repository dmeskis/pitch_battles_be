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
  describe 'delete' do
    it 'can delete a class if user is teacher who created it' do
      teacher = User.new(email: 'teacher@mail.com',
                      password: 'password',
                      password_confirmation: 'password',
                      first_name: 'Bob',
                      last_name: 'Ross',
                      role: 1)
      teacher.save

      body = {
        email: 'teacher@mail.com',
        password: 'password'
      }

      post '/login', :params => body

      klass = create(:klass, teacher_id: teacher.id)

      key = JSON.parse(response.body)["access_token"]
      delete "/api/v1/classes/#{klass.id}", :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(parsed["success"]).to eq("Successfully deleted #{klass.name}.")
    end
    it 'cannot delete a class if user is not the teacher who created it' do
      teacher = User.new(email: 'teacher@mail.com',
                        password: 'password',
                        password_confirmation: 'password',
                        first_name: 'Bob',
                        last_name: 'Ross',
                        role: 1)
      teacher.save

      teacher_2 = User.new(email: 'teacher_2@mail.com',
                            password: 'password',
                            password_confirmation: 'password',
                            first_name: 'Carl',
                            last_name: 'Jenkins',
                            role: 1)
      teacher_2.save

      body = {
      email: 'teacher@mail.com',
      password: 'password'
      }

      post '/login', :params => body

      klass = create(:klass, teacher_id: teacher_2.id)

      key = JSON.parse(response.body)["access_token"]
      delete "/api/v1/classes/#{klass.id}", :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(401)
      # expect(parsed.body["error"]).to eq("Succesfully deleted #{klass.name}.")
    end
  end
end