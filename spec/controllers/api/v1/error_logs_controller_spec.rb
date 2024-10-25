# spec/controllers/api/v1/error_logs_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::V1::ErrorLogsController, type: :controller do
  describe 'POST #create' do
    let(:application) { create(:application) }
    let(:status) { create(:status) }
    let(:valid_params) do
      {
        application_id: application.id,
        code: Faker::Number.number(digits: 3),
        erro: Faker::Lorem.sentence,
        backtrace: Faker::Lorem.paragraph,
        url: Faker::Internet.url,
        http_method: %w[GET POST PUT DELETE].sample,
        date: '2024-10-21T08:00:00Z',
        status_id: status.id,
        user: {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          ip: Faker::Internet.ip_v4_address
        }
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
          }.to change(ErrorLogWorker.jobs, :size).by(1)

          expect(response).to have_http_status(:accepted)
          expect(JSON.parse(response.body)['status']).to eq('success')
        end
      end

      it 'processes the monitoring data when job is performed' do
        Sidekiq::Testing.inline! do
          expect {
            post :create, params: valid_params
          }.to change(ErrorLog, :count).by(1)
        end
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { valid_params.except(:code) }

      it 'returns unprocessable entity status' do
        post :create, params: invalid_params

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('errors')
      end
    end

    context 'com autenticação inválida' do
      before do
        request.headers['Authorization'] = 'Token token=invalid_key'
      end

      it 'retorna status não autorizado' do
        post :create, params: valid_params

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end