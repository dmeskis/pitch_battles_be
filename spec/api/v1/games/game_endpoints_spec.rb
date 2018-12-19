require 'rails_helper'

describe 'game api', :type => :request do
  describe 'get' do
    it 'can show a single game' do 
      game = create(:game)

      get "/api/v1/games/#{game.id}"

      body = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(body["data"]["attributes"]["total_duration"]).to eq(game.total_duration)
    end
    it 'errors if game does not exist' do
      get '/api/v1/games/-1'

      body = JSON.parse(response.body)

      expect(response.status).to eq(404)
      expect(Game.count).to eq(0)
    end
  end
  describe 'post' do
    it 'can create a new game' do
      user = create(:user)
      body = {
              total_duration: 15000,
              level_one_duration: 3000,
              level_two_duration: 3000,
              level_three_duration: 6000,
              level_four_duration: 3000,
              remaining_life: 2,
              user_id: user.id
            }

      post "/api/v1/users/#{user.id}/games", :params => body

      parsed = JSON.parse(response.body)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(parsed["data"].keys).to contain_exactly('id', 'type', 'attributes')
      expect(Game.count).to eq(1)
      game = Game.first
      expect(game.total_duration).to eq(15000)
      expect(game.remaining_life).to eq(2)
    end
    it 'can fail to post if given wrong information' do
      user = create(:user)
      body = {
              total_duration: 15000,
              level_one_duration: 3000,
              level_two_duration: 3000,
              level_three_duration: 6000,
              level_four_duration: 3000,
              remaining_life: 2
            }

      post "/api/v1/users/#{user.id}/games", :params => body

      parsed = JSON.parse(response.body)
      expect(response.status).to eq(500)
      expect(parsed["error"]).to eq("Failed to save game. Check error logs.")
      expect(Game.count).to eq(0)
    end
  end
end