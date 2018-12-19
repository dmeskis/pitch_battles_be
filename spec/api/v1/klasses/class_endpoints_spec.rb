require 'rails_helper'

describe 'game api', :type => :request do
  describe 'post' do
    it 'can add a user to a class' do
      user = create(:user)
      klass = create(:klass)
      body = {
        class_key: klass.class_key
      }

      post "/api/v1/users/#{user.id}/class", :params => body

      parsed = JSON.parse(response.body)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(klass.users.count).to eq(1)
      expect(klass.users.first.first_name).to eq(user.first_name)
    end
    it 'errors if incorrect credentials' do
      user = create(:user)
      klass = create(:klass)
      body = {
        class_key: "N07 4 R341 |<3Y"
      }

      post "/api/v1/users/#{user.id}/class", :params => body

      parsed = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(parsed["error"]).to eq("Incorrect credentials.")
      expect(klass.users.count).to eq(0)
    end
  end
end