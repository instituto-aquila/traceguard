# app/workers/error_log_worker.rb
class ErrorLogWorker
  include Sidekiq::Worker
  
  sidekiq_options queue: :error_logs, retry: 3
  
  def perform(params)
    error_log_service = ErrorLogs::ProcessorService.new(params.deep_symbolize_keys)
    unless error_log_service.process
      error_message = error_log_service.errors.join(", ")
      Rails.logger.error("Failed to process error log: #{error_message}")
      raise StandardError, error_message
    end
  end
end