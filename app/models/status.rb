class Status < ApplicationRecord
  has_many :error_logs
  
  validates :name, presence: true
  validates :color, presence: true
end
