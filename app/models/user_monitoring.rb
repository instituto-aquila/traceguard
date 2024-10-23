class UserMonitoring < ApplicationRecord
  belongs_to :user
  belongs_to :application

  has_many :pages_visited
  
  validates :date, presence: true
  
  scope :by_date_range, ->(start_date, end_date) { where(date: start_date..end_date) }
end
