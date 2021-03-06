require 'rails_helper'

RSpec.describe Klass, type: :model do
  it 'exists' do
    klass = create(:klass)
    Klass.where(name: klass.name).should exist
  end
  it 'should have a class_key on create' do
    klass = create(:klass)
    expect(klass.class_key).to_not be(nil)
  end
  describe 'attributes' do
    it 'has attributes' do
      klass = create(:klass)
      expect(klass.attributes).to include("name")
    end
  end
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :teacher_id }
    it { should validate_uniqueness_of :class_key}
  end
  describe 'relationships' do
    it { should have_many :users}
    it { should have_many :games}
  end
end
