require 'rails_helper'

RSpec.describe UserMonitoring, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:date) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:application) }
    it { should have_many(:pages_visited) }
  end

  describe 'scopes' do
    let!(:user_monitoring1) { create(:user_monitoring, date: 2.days.ago) }
    let!(:user_monitoring2) { create(:user_monitoring, date: 5.days.ago) }
    let!(:user_monitoring3) { create(:user_monitoring, date: 10.days.ago) }

    it 'returns user monitorings within the date range' do
      expect(UserMonitoring.by_date_range(7.days.ago, Date.today)).to include(user_monitoring1, user_monitoring2)
      expect(UserMonitoring.by_date_range(7.days.ago, Date.today)).not_to include(user_monitoring3)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:user_monitoring)).to be_valid
    end
  end
end