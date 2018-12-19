require 'rails_helper'

describe 'game api', :type => :request do
  describe 'post' do
    it 'can create a new game' do
      body = {
              total_duration: 15000,
              level_one_duration: 3000,
              level_two_duration: 3000,
              level_three_duration: 6000,
              level_four_duration: 3000,
              remaining_lives: 2
            }

      post "/api/v1/user/:id/games", :params => body

      parsed = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(parsed).to eq("success" => "Account successfully created!")
      expect(Game.count).to eq(1)
      user = Game.first
      expect(user.total_duration).to eq(15000)
      expect(user.remaining_lives).to eq(2)
    end
  end
end