require 'rails_helper'
require 'helpers/login_helper'
include LoginHelper

describe 'teacher dashboard integration', :type => :request do
  describe 'index' do
    it 'gets teacher classes' do
      create_teacher
      login
      user = User.first

      klass = create(:klass, teacher_id: user.id)

      key = JSON.parse(response.body)["access_token"]

      get "/api/v1/teacher_dashboard", :headers => {'AUTHORIZATION': "bearer #{key}"}
      body = JSON.parse(response.body)
      expect(body["data"][0]["attributes"]["name"]).to eq(klass.name)
    end
  end
  describe 'show' do
    it 'gets teacher classes' do
      create_teacher
      login
      user = User.first

      klass = create(:klass, teacher_id: user.id)
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

      get "/api/v1/teacher_dashboard/classes/#{klass.id}", :headers => {'AUTHORIZATION': "bearer #{key}"}
      body = JSON.parse(response.body)
      binding.pry
      expect(body["data"]["attributes"]["most_badges"]["badges"]).to eq(klass.most_badges[:badges])
      expect(body["data"]["attributes"]["most_games"]["total_games"]).to eq(klass.most_games[:total_games])
    end
  end
end