# app/workers/monitoring_worker.rb
class MonitoringWorker
  include Sidekiq::Worker
  
  sidekiq_options queue: :monitoring, retry: 3
  
  def perform(params)
    monitoring_service = Monitoring::ProcessorService.new(params.deep_symbolize_keys)
    unless monitoring_service.process
      error_message = monitoring_service.errors.join(", ")
      Rails.logger.error("Failed to process monitoring: #{error_message}")
      raise StandardError, error_message
    end
  end
end