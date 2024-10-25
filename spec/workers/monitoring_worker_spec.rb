# spec/workers/monitoring_worker_spec.rb
require 'rails_helper'

RSpec.describe MonitoringWorker, type: :worker do
  describe '#perform' do
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

    it 'processes monitoring data successfully' do
      expect {
        subject.perform(valid_params)
      }.to change(PagesVisited, :count).by(1)
    end

    context 'when processing fails' do
      let(:invalid_params) { valid_params.except(:date) }

      it 'raises an error' do
        expect {
          subject.perform(invalid_params)
        }.to raise_error(StandardError)
      end
    end
  end
end