require 'rails_helper'

RSpec.describe PagesVisited, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:page_url) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
    it { should validate_presence_of(:duration_seconds) }
  end

  describe 'associations' do
    it { should belong_to(:user_monitoring) }
  end

  describe 'scopes' do
    let!(:pages_visited1) { create(:pages_visited, start_time: 2.days.ago) }
    let!(:pages_visited2) { create(:pages_visited, start_time: 5.days.ago) }
    let!(:pages_visited3) { create(:pages_visited, start_time: 10.days.ago) }

    it 'returns pages visited within the date range' do
      expect(PagesVisited.by_date_range(7.days.ago, Date.today)).to include(pages_visited1, pages_visited2)
      expect(PagesVisited.by_date_range(7.days.ago, Date.today)).not_to include(pages_visited3)
    end
  end

  describe 'factory' do
    it 'has a valid factory' do
      expect(build(:pages_visited)).to be_valid
    end
  end
end