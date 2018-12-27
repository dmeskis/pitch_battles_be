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
    binding.pry
    expect(response.status).to eq(200)
    expect(current_email).to exist
  end
end