require 'rails_helper'

RSpec.describe Status, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:color) }
  end

  describe 'associations' do
    it { should have_many(:error_logs) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:status)).to be_valid
    end
  end
end