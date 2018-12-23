require 'rails_helper'

describe 'klass api', :type => :request do
  before :each do
    @user = create(:user)
    Api::V1::Users::KlassesController.any_instance.stub(:authenticate_request).and_return(@user)
  end 
  describe 'post' do
    it 'can add a user to a class' do
      user = create(:user, role: 1)
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
      user = create(:user, role: 1)
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
    it 'does not allow a user to create a class if they are not a teacher' do
      user = create(:user, role: 0)
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
  end
end