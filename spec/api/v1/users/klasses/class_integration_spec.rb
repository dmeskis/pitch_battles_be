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
  end
end