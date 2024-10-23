require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end

  describe 'associations' do
    it { should have_many(:user_monitorings) }
    it { should have_many(:error_logs) }
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:application)).to be_valid
    end
  end
end