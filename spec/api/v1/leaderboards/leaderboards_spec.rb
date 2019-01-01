require 'rails_helper'
require 'helpers/login_helper'
include LoginHelper

describe 'leaderboards', :type => :request do
  describe 'get' do
    before :each do
      150.times do
        create(:game)
      end
    end
    it 'returns the top 100 scores for level one' do
      create_student
      login
      key = JSON.parse(response.body)["access_token"]

      get '/api/v1/leaderboards?type=level_one', :headers => {'AUTHORIZATION': "bearer #{key}"}

      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json[:data][:type]).to contain_exactly('highscore')
      expect(json[:data][0][:attributes]).to contain_exactly('highscore')
      expect(json[:data][0][:attributes][:highscore]).to_not eq(0)
      binding.pry
    end
  end
end