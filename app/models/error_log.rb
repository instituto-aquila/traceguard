# app/models/error_log.rb
class ErrorLog < ApplicationRecord
  belongs_to :application
  belongs_to :status
  belongs_to :user

  validates :code, presence: true
  validates :erro, presence: true
  validates :date, presence: true
  validates :url, presence: true
  
  scope :by_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }
  scope :by_status, ->(status_id) { where(status_id: status_id) }
  scope :by_application, ->(id) { where(application_id: id) if id.present? }
  scope :by_code, ->(code) { where(code: code) if code.present? }


end
