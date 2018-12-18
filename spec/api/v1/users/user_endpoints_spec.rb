require 'rails_helper'

describe 'user api', :type => :request do
  it 'can create a user' do
    body = {
            email: "example@mail.com",
            first_name: "billy",
            last_name: "bob",
            role: 0,
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
    expect(user.role).to eq(0)
  end
  it 'fails to post a user if info is incorrect' do

    body = {
      email: '',
      first_name: "billy",
      last_name: "",
      role: 0,
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

# post /api/v1/users

# As a user,
# I send the following request:

# {
# email: “example@mail.com”,
# first_name: “billy”,
# last_name: “bob”,
# role: 0,
# password: “password”,
# password_confirmation: “password”
# }

# All fields are required.
# If post is successful, returns the following response with status 200:
# Response
# {
# “success”: “Account successfully created”
# }

# If post fails, returns the following response with a 400 error:
# {
# "error": "Account creation failed. Please try again."
# }