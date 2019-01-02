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
        create(:user, klass_id: klass.id)
      end

      key = JSON.parse(response.body)["access_token"]

      get "/api/v1/class_dashboard", :headers => {'AUTHORIZATION': "bearer #{key}"}
      body = JSON.parse(response.body)
      # expect(body["data"]["attributes"]).to eq(user.first_name)
      students = [
        l1_fastest = body["data"]["attributes"]["level_one_fastest_time"][0],
        l2_fastest = body["data"]["attributes"]["level_two_fastest_time"][0],
        l3_fastest = body["data"]["attributes"]["level_three_fastest_time"][0],
        l4_fastest = body["data"]["attributes"]["level_four_fastest_time"][0],
        l5_fastest = body["data"]["attributes"]["overall_fastest_time"][0],
      ]
      result = students.max_by do |student|
        student['level_one_fastest_time']
      end
      expect(result).to be(l1_fastest) 

      User.first.delete
    end
  end
end