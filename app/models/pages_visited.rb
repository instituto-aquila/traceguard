class PagesVisited < ApplicationRecord
  belongs_to :user_monitoring

  validates :page_url, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :duration_seconds, presence: true
  
  scope :by_date_range, ->(start_date, end_date) { where(start_time: start_date..end_date) }
end
