# app/workers/error_log_worker.rb
class ErrorLogWorker
  include Sidekiq::Worker
  
  sidekiq_options queue: :error_logs, retry: 3
  
  def perform(error_log_id)
    error_log = ErrorLog.find(error_log_id)
    # Aqui você pode adicionar lógicas adicionais como:
    # - Enviar alertas
    # - Notificar equipe responsável
    # - Atualizar métricas de erro
  end
end