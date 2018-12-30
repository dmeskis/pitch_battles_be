require 'rails_helper'

describe 'password_reset' do
  before :each do
    @user = create(:user)
  end
  it 'user can receive a password reset email' do
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
    key = JSON.parse(response.body)["access_token"]

  end
end