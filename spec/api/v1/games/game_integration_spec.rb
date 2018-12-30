require 'rails_helper'

describe 'game integration', :type => :request do
  describe 'post' do
    it 'can post a game' do
      create_student
      login

      key = JSON.parse(response.body)["access_token"]

      body = {
        perfectScores: { "one": true, "two": true, three: true, four: true, all: false },
        times: {"one": 11111, "two": 22222, "three": nil, "four": nil, all: 33333}
      }

      post "/api/v1/games", :params => body, :headers => {'AUTHORIZATION': "bearer #{key}"}

      parsed = JSON.parse(response.body)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(parsed["data"].keys).to contain_exactly('id', 'type', 'attributes')
      expect(Game.count).to eq(1)
      game = Game.first
      expect(game.level_one_duration).to eq(11111)
      expect(game.level_one_perfect).to eq(true)
      expect(game.level_four_perfect).to eq(true)
      expect(game.total_duration).to eq(33333)
    end
    it 'fails to post without correct information' do
      create_student
      login

      key = JSON.parse(response.body)["access_token"]

      body = {
        total_duration: 15000,
        level_one_duration: 3000,
        level_two_duration: 3000,
        level_three_duration: 6000,
        level_four_duration: 3000
      }

      post "/api/v1/games", :params => body, :headers => {'AUTHORIZATION': "bearer #{key}"}

      parsed = JSON.parse(response.body)
      expect(response.status).to eq(422)
      expect(parsed["error"]).to eq("Invalid game data.")
      expect(Game.count).to eq(0)
    end
  end
end