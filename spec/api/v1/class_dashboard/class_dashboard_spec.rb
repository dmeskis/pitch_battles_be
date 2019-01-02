require 'rails_helper'
require 'helpers/login_helper'
include LoginHelper

describe 'class dashboard integration', :type => :request do
  describe 'show' do
    it 'gets class data at the class dashboard endpoint' do
      create_student
      login
      user = User.first

      klass = create(:klass)
      klass.users << user
      10.times do
        user = create(:user, klass_id: klass.id)
        rand(0..10).times do
          create(:game, user_id: user.id)
        end
        rand(0..10).times do
          user.badges << create(:badge)
        end
      end


      key = JSON.parse(response.body)["access_token"]

      get "/api/v1/class_dashboard", :headers => {'AUTHORIZATION': "bearer #{key}"}
      body = JSON.parse(response.body)
      students = [
        l1_fastest = body["data"]["attributes"]["level_one_fastest_time"]['user']['data'][0],
        l2_fastest = body["data"]["attributes"]["level_two_fastest_time"]['user']['data'][0],
        l3_fastest = body["data"]["attributes"]["level_three_fastest_time"]['user']['data'][0],
        l4_fastest = body["data"]["attributes"]["level_four_fastest_time"]['user']['data'][0],
        l5_fastest = body["data"]["attributes"]["overall_fastest_time"]['user']['data'][0],
      ]

      result = students.min_by do |student|
        student['level_one_fastest_time']
      end

      expect(result).to be(l1_fastest)
      expect(body["data"]["attributes"]["most_badges"]["badges"]).to eq(klass.most_badges[:badges])
      expect(body["data"]["attributes"]["most_games"]["total_games"]).to eq(klass.most_games[:total_games])
    end
    it '404 if no user class' do
      create_student
      login
      user = User.first

      key = JSON.parse(response.body)["access_token"]

      get "/api/v1/class_dashboard", :headers => {'AUTHORIZATION': "bearer #{key}"}
      json = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(json["error"]).to eq("No class associated with user.")
    end
  end
end