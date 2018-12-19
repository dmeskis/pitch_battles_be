require 'rails_helper'

RSpec.describe Badge, type: :model do
  it 'exists' do
    badge = create(:badge)
    Badge.where(name: badge.name).should exist
  end
  
  describe 'validations' do
    it { should validate_presence_of :name}
    it { should validate_presence_of :description}
  end

  describe 'relationships' do
    it {should have_many :users}
  end
end
