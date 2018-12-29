require 'rails_helper'

RSpec.describe BadgeAnalysis do
  it 'exists' do
    ba = BadgeAnalysis.new
    ba.should exist
  end

  describe 'relationships' do
    it {should have_many :users}
  end
  
end