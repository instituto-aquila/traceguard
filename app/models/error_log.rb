class ErrorLog < ApplicationRecord
  belongs_to :application
  belongs_to :status
  belongs_to :user

  validates :code, presence: true
  validates :erro, presence: true
  validates :date, presence: true
  
  scope :by_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }
  scope :by_status, ->(status_id) { where(status_id: status_id) }
end
