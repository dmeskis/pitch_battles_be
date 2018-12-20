require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid' do
    user = create(:user)
    expect(user.valid?).to eq(true)
  end
  it 'should have an auth token on create' do
    user = create(:user)
    expect(user.auth_token).to be_a(String)
  end
  describe 'attributes' do
    it 'has attributes' do
      user = create(:user)
      expect(user.attributes).to include("first_name")
      expect(user.attributes).to include("last_name")
      expect(user.attributes).to include("role")
      expect(user.attributes).to include("password_digest")
      expect(user.attributes).to include("avatar")
      expect(user.attributes).to include("auth_token")
    end
  end
  describe 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :password }
    it { should validate_presence_of :role }
    it { should validate_presence_of :auth_token }
    it { should validate_uniqueness_of :email }
  end
  describe 'relationships' do
    it { should have_many :klasses }
    it { should have_many :games }
    it { should have_many :badges}
  end
end