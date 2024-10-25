# spec/workers/error_logs_worker_spec.rb
require 'rails_helper'

RSpec.describe ErrorLogWorker, type: :worker do
  describe '#perform' do
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

    it 'processes error log data successfully' do
      expect {
        subject.perform(valid_params)
      }.to change(ErrorLog, :count).by(1)
    end

    context 'when processing fails' do
      let(:invalid_params) { valid_params.except(:code) }

      it 'raises an error' do
        expect {
          subject.perform(invalid_params)
        }.to raise_error(StandardError)
      end
    end
  end
end