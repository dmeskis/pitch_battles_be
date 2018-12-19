require 'rails_helper'

describe 'badge api', :type => :request do
  describe 'get' do
    it 'can get all user badges' do 
      user = create(:user)
      badge = create(:badge)
      user.badges << badge
      get "/api/v1/users/#{user.id}/badges"

      body = JSON.parse(response.body)
      
      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(body["data"]["relationships"]["badges"]["attributes"][0]["name"]).to eq(badge.name)
    end
    xit 'errors if incorrect data' do

    end
  end
end


# As a user,
# I send a GET request to api/v1/users/:id/badges

# Upon a successful request I get the following response (200):

# {
# data: {
# id: <user_id>,
# type: "User",
# attributes: { <user_attributes> },
# badges: { }
# }
# }