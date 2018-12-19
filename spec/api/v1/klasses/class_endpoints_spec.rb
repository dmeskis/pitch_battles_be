require 'rails_helper'

describe 'game api', :type => :request do
  describe 'post' do
    it 'can add a user to a class' do
      user = create(:user)
      klass = create(:klass)
      binding.pry
      body = {
        class_key: klass.class_key
      }

      post "/api/v1/users/#{user.id}/class", :params => body

      parsed = JSON.parse(response.body)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(user.klasses.count).to eq(1)
    end
  end
end