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
    end
  end
end