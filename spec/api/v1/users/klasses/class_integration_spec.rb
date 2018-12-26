require 'rails_helper'

describe 'klass api', :type => :request do
  describe 'delete' do 
    it 'can delete a user from a class' do
      klass = create(:klass)

      user = User.new(email: 'teacher@mail.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Bob',
        last_name: 'Ross',
        role: 1)

      user.save

      klass.users << user

      body =  {
                email: 'teacher@mail.com',
                password: 'password'
              }

      post '/login', :params => body
  
      key = JSON.parse(response.body)["access_token"]
      delete "/api/v1/users/#{user.id}/classes/#{klass.id}", :headers => {'AUTHORIZATION': "bearer #{key}"}

      parsed = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(parsed["success"]).to eq("Successfully removed #{user.first_name} #{user.last_name} from #{klass.name}.")
      expect(klass.users.count).to eq(0)
    end
    it 'does not let one delete a user from a class if they are not the student being deleted' do
      klass = create(:klass)

      user = User.new(email: 'teacher@mail.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Bob',
        last_name: 'Ross',
        role: 1)

      user.save

      user_2 = create(:user, role: 0)

      klass.users << user

      body =  {
                email: 'teacher@mail.com',
                password: 'password'
              }

      post '/login', :params => body
      
      key = JSON.parse(response.body)["access_token"]
      # Attempting to delete user 2 with user 1 being the one logged in
      delete "/api/v1/users/#{user_2.id}/classes/#{klass.id}", :headers => {'AUTHORIZATION': "bearer #{key}"}

      parsed = JSON.parse(response.body)
      expect(response.status).to eq(403)
      expect(parsed["error"]).to eq("Insufficient permissions to remove user from #{klass.name}.")
      expect(klass.users.count).to eq(1)
    end
    it 'allows a user to be deleted from a class if it is the teacher attempting to remove them' do

      user = User.new(email: 'teacher@mail.com',
        password: 'password',
        password_confirmation: 'password',
        first_name: 'Bob',
        last_name: 'Ross',
        role: 1)

      user.save

      klass = create(:klass, teacher_id: user.id)

      user_2 = create(:user, role: 0)

      klass.users << user

      body =  {
                email: 'teacher@mail.com',
                password: 'password'
              }

      post '/login', :params => body
      
      key = JSON.parse(response.body)["access_token"]
      # Attempting to delete user 2 with user 1 being the teacher logged in
      delete "/api/v1/users/#{user_2.id}/classes/#{klass.id}", :headers => {'AUTHORIZATION': "bearer #{key}"}

      parsed = JSON.parse(response.body)
      expect(response.status).to eq(200)
      expect(parsed["success"]).to eq("Successfully removed #{user_2.first_name} #{user_2.last_name} from #{klass.name}.")
      expect(klass.users.count).to eq(1)
    end
  end
end