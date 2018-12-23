require 'rails_helper'

describe 'game api', :type => :request do
  before :each do
    @user = create(:user)
    Api::V1::Users::KlassesController.any_instance.stub(:authenticate_request).and_return(@user)
  end 
  describe 'post' do
    it 'can create a class if user is teacher' do
      user = create(:user, role: 1)

      post "/api/v1/klasses"

      parsed = JSON.parse(response.body)
      binding.pry
    end
    xit 'cannot create a class if user is not teacher' do

      post "/api/v1/users/#{user.id}/class", :params => body

      parsed = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(parsed["error"]).to eq("Incorrect credentials.")
      expect(klass.users.count).to eq(0)
    end
  end
end