require 'rails_helper'

describe 'password_reset' do
  before :each do
    @user = create(:user)
  end
  it 'user can reset a password' do
    body = {
      email: @user.email
    }
    post '/password/forgot', :params => body
  end
end