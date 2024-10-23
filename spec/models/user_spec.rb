# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:name) }
  end
  
  describe 'associations' do
    it { should have_many(:user_monitorings) }
    it { should have_many(:error_logs) }
  end
  
  describe '.find_or_create_by_email' do
    let(:user_params) do
      {
        email: 'test@example.com',
        name: 'Test User',
        ip: '127.0.0.1'
      }
    end
    
    it 'creates a new user when not found' do
      expect {
        User.find_or_create_by_email(user_params)
      }.to change(User, :count).by(1)
    end
    
    it 'updates existing user when found' do
      existing_user = User.create!(user_params)
      updated_params = user_params.merge(name: 'Updated Name')
      
      user = User.find_or_create_by_email(updated_params)
      
      expect(user.name).to eq('Updated Name')
      expect(User.count).to eq(1)
    end
  end
end