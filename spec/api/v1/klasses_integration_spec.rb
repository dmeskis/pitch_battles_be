require 'rails_helper'
require 'helpers/login_helper'
include LoginHelper

describe 'game api', :type => :request do
  describe 'post' do
    it 'can create a class if user is teacher' do
      create_teacher
      login

      class_body = {
        name: "My class"
      }

      key = JSON.parse(response.body)["access_token"]
      post "/api/v1/classes", :params => class_body, :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(parsed["data"]["attributes"].keys).to contain_exactly('id', "name", "class_key")
      expect(Klass.first.class_key).to eq(parsed["data"]["attributes"]["class_key"])
    end
    it 'cannot create a class if user is not teacher' do
      create_student
      login

      class_body = {
      name: "My class"
      }

      key = JSON.parse(response.body)["access_token"]
      post "/api/v1/classes", :params => class_body, :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(401)
      expect(parsed["error"]).to eq("Teacher privileges required.")
    end
    it 'cannot create a class if name is blank' do
      create_teacher
      login

      class_body = {
      name: ""
      }

      key = JSON.parse(response.body)["access_token"]
      post "/api/v1/classes", :params => class_body, :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(422)
    end
    it 'cannot create a class if no name is provided' do
      create_teacher
      login

      key = JSON.parse(response.body)["access_token"]
      post "/api/v1/classes", :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(422)
      expect(parsed["error"]).to eq("You must enter a class name.")
    end
  end
  describe 'delete' do
    it 'can delete a class if user is teacher who created it' do
      create_teacher
      login
      teacher = User.first

      klass = create(:klass, teacher_id: teacher.id)
      key = JSON.parse(response.body)["access_token"]
      delete "/api/v1/classes/#{klass.id}", :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(parsed["success"]).to eq("Successfully deleted #{klass.name}.")
    end
    it 'cannot delete a class if user is not the teacher who created it' do
      create_teacher
      login

      teacher_2 = User.new(email: 'teacher_2@mail.com',
                            password: 'password',
                            password_confirmation: 'password',
                            first_name: 'Carl',
                            last_name: 'Jenkins',
                            role: 1)
      teacher_2.save

      klass = create(:klass, teacher_id: teacher_2.id)

      key = JSON.parse(response.body)["access_token"]
      delete "/api/v1/classes/#{klass.id}", :headers => {'AUTHORIZATION': "bearer #{key}"}
      parsed = JSON.parse(response.body)
      expect(response.status).to eq(401)
    end
  end
end