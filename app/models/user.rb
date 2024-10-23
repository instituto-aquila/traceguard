class User < ApplicationRecord
  has_many :user_monitorings
  has_many :error_logs
  
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
  
  def self.find_or_create_by_email(params)
    Rails.cache.fetch("user/#{params[:email]}", expires_in: 1.hour) do
      user = find_or_initialize_by(email: params[:email])
      user.name = params[:name]
      user.ip = params[:ip]
      user.save
      user
    end
  end
end
