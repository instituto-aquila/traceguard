class Application < ApplicationRecord
  has_many :user_monitorings
  has_many :error_logs
  
  validates :name, presence: true, uniqueness: true
end
