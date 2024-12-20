# spec/controllers/api/v1/monitoring_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::MonitoringController, type: :controller do
  describe 'POST #create' do
    let(:application) { create(:application) }
    let(:valid_params) do
      {
        application_id: application.id,
        date: '2024-10-21T08:00:00Z',
        user: {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          ip: Faker::Internet.ip_v4_address
        },
        pages_visited: [
          {
            page_url: Faker::Internet.url,
            start_time: '2024-10-21T08:00:00Z',
            end_time: '2024-10-21T08:30:00Z',
            duration_seconds: 1800,
            publication_id: Faker::Number.between(from: 1, to: 100),
            publication_title: Faker::Lorem.sentence
          }
        ]
      }
    end

    before do
      request.headers['Authorization'] = "Token token=#{application.api_key}"
    end

    context 'with valid params' do
      it 'enqueues a worker and returns accepted status' do
        Sidekiq::Testing.fake! do
          expect {
            post :create, params: valid_params
          }.to change(MonitoringWorker.jobs, :size).by(1)
          
          expect(response).to have_http_status(:accepted)
          expect(JSON.parse(response.body)['status']).to eq('success')
        end
      end

      it 'processes the monitoring data when job is performed' do
        Sidekiq::Testing.inline! do
          expect {
            post :create, params: valid_params
          }.to change(PagesVisited, :count).by(1)
        end
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { valid_params.except(:date) }

      it 'returns unprocessable entity status' do
        post :create, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end
  end
end