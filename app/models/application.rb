class Application < ApplicationRecord
  before_create :generate_api_key

  has_many :user_monitorings
  has_many :error_logs
  
  validates :name, presence: true, uniqueness: true

  private

  def generate_api_key
    self.api_key = SecureRandom.hex(20)
  end
end
