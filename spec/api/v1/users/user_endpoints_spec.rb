require 'rails_helper'

describe 'user api', :type => :request do
  before :each do
    @user = create(:user)
    Api::V1::UsersController.any_instance.stub(:authenticate_request).and_return(@user)
    Api::V1::Users::GamesController.any_instance.stub(:authenticate_request).and_return(@user)
  end 
  describe 'post' do
    it 'can create a user' do
      User.first.delete
      body = {
              email: "example@mail.com",
              first_name: "billy",
              last_name: "bob",
              role: "student",
              password: "password",
              password_confirmation: "password"
      }

      post "/api/v1/users", :params => body

      parsed = JSON.parse(response.body)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(parsed).to eq("success" => "Account successfully created!")
      expect(User.count).to eq(1)
      user = User.first
      expect(user.first_name).to eq("billy")
      expect(user.last_name).to eq("bob")
      expect(user.role).to eq("student")
    end
    it 'fails to post a user if info is incorrect' do
      User.first.delete
      body = {
        email: '',
        first_name: "billy",
        last_name: "",
        role: "teacher",
        password: "password",
        password_confirmation: "password"
      }

      post "/api/v1/users", :params => body

      parsed = JSON.parse(response.body)

      expect(response.status).to eq(400)
      expect(parsed).to eq("error" => "Account creation failed.")
      expect(User.count).to eq(0)
    end
  end
  describe 'get' do
    it 'can get a users data' do
      get "/api/v1/users/#{@user.id}"

      body = JSON.parse(response.body)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(body.keys).to contain_exactly('data')
      expect(body["data"].keys).to contain_exactly('id', 'type', 'attributes')
      expect(body["data"]["type"]).to eq("user")
      expect(body["data"]["attributes"].keys).to contain_exactly('email', 
                                                                 'first_name', 
                                                                 'last_name', 
                                                                 'avatar', 
                                                                 'role',
                                                                 'level_one_fastest_time',
                                                                 'level_two_fastest_time',
                                                                 'level_three_fastest_time',
                                                                 'level_four_fastest_time',
                                                                 'total_games_played',
                                                                 'games', 
                                                                 'badges', 
                                                                 'classes')
    end
    it 'does not return a users data which does not exit' do
      get "/api/v1/users/-1"

      body = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(body["error"]).to eq("User not found.")
    end
  end
  describe 'patch' do
    xit 'can patch a user' do
      params = {
                email: Faker::Internet.email
               }
      patch "/api/v1/users", :params => params

      body = JSON.parse(response.body)

      updated_user = User.find(@user.id)
      expect(response).to be_successful
      expect(body["data"].keys).to contain_exactly('id', 'type', 'attributes')
      expect(updated_user.email).to eq(params[:email])
    end
    it 'can fail to patch a user' do
      params = {
                role: 1
               }

      patch "/api/v1/users", :params => params

      body = JSON.parse(response.body)

      updated_user = User.find(@user.id)
    
      expect(response.status).to eq(422)
      expect(body["error"]).to eq("No update fields submitted. Resend request with valid update fields.")
    end
  end
  describe 'users games' do
    it 'can get all user games' do 
      game = create(:game)
      user = User.find(game.user_id)
      4.times do
        create(:game, user_id: user.id)
      end
      get "/api/v1/users/#{user.id}/games"
      body = JSON.parse(response.body)
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(body["data"]["attributes"]["games"]["data"].count).to eq(5)
      expect(body["data"]["attributes"]["games"]["data"][0]["id"]).to eq(game.id.to_s)
    end
    it 'errors if user does not exist' do

      get "/api/v1/users/-1/games"
      body = JSON.parse(response.body)
      expect(response.status).to eq(404)
      expect(body["error"]).to eq("User not found.")
    end
  end
end