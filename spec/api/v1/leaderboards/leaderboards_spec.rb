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
      level = 'level_one'

      get "/api/v1/leaderboards?type=#{level}", :headers => {'AUTHORIZATION': "bearer #{key}"}

      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json['data'][0]['type']).to eq('user')
      expect(json['data'][0]['attributes']['highscore']).to_not eq(0)
      expect(json['data'][0]['attributes']['highscore']).to be < json['data'][1]['attributes']['highscore']
      expect(json['data'][1]['attributes']['highscore']).to be < json['data'][2]['attributes']['highscore']
      expect(json['data'][2]['attributes']['highscore']).to be < json['data'][3]['attributes']['highscore']
      expect(json['data'][3]['attributes']['highscore']).to be < json['data'][4]['attributes']['highscore']
      expect(json['data'][4]['attributes']['highscore']).to be < json['data'][5]['attributes']['highscore']
    end
    it 'returns the top 100 scores for level two' do
      create_student
      login
      key = JSON.parse(response.body)["access_token"]
      level = 'level_two'

      get "/api/v1/leaderboards?type=#{level}", :headers => {'AUTHORIZATION': "bearer #{key}"}

      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json['data'][0]['type']).to eq('user')
      expect(json['data'][0]['attributes']['highscore']).to_not eq(0)
      expect(json['data'][0]['attributes']['highscore']).to be < json['data'][1]['attributes']['highscore']
      expect(json['data'][1]['attributes']['highscore']).to be < json['data'][2]['attributes']['highscore']
      expect(json['data'][2]['attributes']['highscore']).to be < json['data'][3]['attributes']['highscore']
      expect(json['data'][3]['attributes']['highscore']).to be < json['data'][4]['attributes']['highscore']
      expect(json['data'][4]['attributes']['highscore']).to be < json['data'][5]['attributes']['highscore']
    end
    it 'returns the top 100 scores for level three' do
      create_student
      login
      key = JSON.parse(response.body)["access_token"]
      level = 'level_three'

      get "/api/v1/leaderboards?type=#{level}", :headers => {'AUTHORIZATION': "bearer #{key}"}

      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json['data'][0]['type']).to eq('user')
      expect(json['data'][0]['attributes']['highscore']).to_not eq(0)
      expect(json['data'][0]['attributes']['highscore']).to be < json['data'][1]['attributes']['highscore']
      expect(json['data'][1]['attributes']['highscore']).to be < json['data'][2]['attributes']['highscore']
      expect(json['data'][2]['attributes']['highscore']).to be < json['data'][3]['attributes']['highscore']
      expect(json['data'][3]['attributes']['highscore']).to be < json['data'][4]['attributes']['highscore']
      expect(json['data'][4]['attributes']['highscore']).to be < json['data'][5]['attributes']['highscore']
    end
    it 'returns the top 100 scores for level four' do
      create_student
      login
      key = JSON.parse(response.body)["access_token"]
      level = 'level_four'

      get "/api/v1/leaderboards?type=#{level}", :headers => {'AUTHORIZATION': "bearer #{key}"}

      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json['data'][0]['type']).to eq('user')
      expect(json['data'][0]['attributes']['highscore']).to_not eq(0)
      expect(json['data'][0]['attributes']['highscore']).to be < json['data'][1]['attributes']['highscore']
      expect(json['data'][1]['attributes']['highscore']).to be < json['data'][2]['attributes']['highscore']
      expect(json['data'][2]['attributes']['highscore']).to be < json['data'][3]['attributes']['highscore']
      expect(json['data'][3]['attributes']['highscore']).to be < json['data'][4]['attributes']['highscore']
      expect(json['data'][4]['attributes']['highscore']).to be < json['data'][5]['attributes']['highscore']
    end
    it 'returns the top 100 scores for all levels' do
      create_student
      login
      key = JSON.parse(response.body)["access_token"]
      level = 'overall'

      get "/api/v1/leaderboards?type=#{level}", :headers => {'AUTHORIZATION': "bearer #{key}"}
      json = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json['data'][0]['type']).to eq('user')
      expect(json['data'][0]['attributes']['highscore']).to_not eq(0)
      expect(json['data'][0]['attributes']['highscore']).to be < json['data'][1]['attributes']['highscore']
      expect(json['data'][1]['attributes']['highscore']).to be < json['data'][2]['attributes']['highscore']
      expect(json['data'][2]['attributes']['highscore']).to be < json['data'][3]['attributes']['highscore']
      expect(json['data'][3]['attributes']['highscore']).to be < json['data'][4]['attributes']['highscore']
      expect(json['data'][4]['attributes']['highscore']).to be < json['data'][5]['attributes']['highscore']
    end
  end
end