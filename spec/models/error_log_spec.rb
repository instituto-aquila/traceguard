require 'rails_helper'

RSpec.describe ErrorLog, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:erro) }
    it { should validate_presence_of(:date) }
  end

  describe 'associations' do
    it { should belong_to(:application) }
    it { should belong_to(:status) }
    it { should belong_to(:user) }
  end

  describe 'scopes' do
    let!(:status1) { create(:status) }
    let!(:status2) { create(:status) }
    let!(:error_log1) { create(:error_log, date: 2.days.ago, status: status1) }
    let!(:error_log2) { create(:error_log, date: 5.days.ago, status: status2) }
    let!(:error_log3) { create(:error_log, date: 10.days.ago, status: status1) }

    it 'returns error logs within the date range' do
      expect(ErrorLog.by_date_range(7.days.ago, Date.today)).to include(error_log1, error_log2)
      expect(ErrorLog.by_date_range(7.days.ago, Date.today)).not_to include(error_log3)
    end

    it 'returns error logs with the specified status' do
      expect(ErrorLog.by_status(status1.id)).to include(error_log1, error_log3)
      expect(ErrorLog.by_status(status1.id)).not_to include(error_log2)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:error_log)).to be_valid
    end
  end
end