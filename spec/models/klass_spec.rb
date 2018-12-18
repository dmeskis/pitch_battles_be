require 'rails_helper'

RSpec.describe Klass, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of :class_key}
  end
end
