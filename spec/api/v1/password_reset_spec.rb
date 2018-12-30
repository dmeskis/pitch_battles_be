require 'rails_helper'

describe 'password_reset', type: :request do
  before :each do
    @user = create(:user)
  end
  it 'user can reset password' do
    body = {
      email: @user.email
    }
    post '/password/forgot', :params => body
    open_email("#{@user.email}")
    user = User.find(@user.id)
    expect(response.status).to eq(200)
    expect(current_email).to have_content("To reset your password, please use the following token in the password reset form: #{user.reset_password_token}. The token is valid for 4 hours.")
    # Flesh out later

    # Send reset request
    user = User.find(@user.id)
    body = {
      password: "newpassword",
      token: user.reset_password_token
    }


    post '/password/reset', :params => body

    # Login with new password
    body = {
      email: user.email,
      password: 'newpassword'
    }

    post '/login', :params => body
    parsed = JSON.parse(response.body)
    key = parsed["access_token"]
    expect(parsed["message"]).to eq("Login Successful")
  end
  it 'user forgets email' do
    post '/password/forgot'
    json = JSON.parse(response.body)
    expect(json["error"]).to eq('Email not present')
  end
  it 'user does not exist' do
    body = {
      email: "NotAnEmail@mail.com"
    }
    post '/password/forgot', :params => body
    json = JSON.parse(response.body)
    expect(json["error"]).to eq('Email address not found. Please check and try again.')
  end
  it 'short password' do
    @user.generate_password_token!
    body = {
      password: "a",
      token: @user.reset_password_token
    }
    post '/password/reset', :params => body
    json = JSON.parse(response.body)
    expect(json["message"]).to eq('Validation failed: Password is too short (minimum is 6 characters)')
  end
  it 'blank password' do
    @user.generate_password_token!
    body = {
      password: "",
      token: @user.reset_password_token
    }
    post '/password/reset', :params => body
    json = JSON.parse(response.body)
    expect(json["error"]).to eq('Password cannot be blank.')
  end
  it 'invalid token' do
    body = {
      password: "newpassword",
      token: 'badtoken'
    }
    post '/password/reset', :params => body
    json = JSON.parse(response.body)
    expect(json["error"]).to eq('Link not valid or expired. Try generating a new link.')
  end
end