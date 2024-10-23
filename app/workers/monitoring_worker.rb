# app/workers/monitoring_worker.rb
class MonitoringWorker
  include Sidekiq::Worker
  
  sidekiq_options queue: :monitoring, retry: 3
  
  def perform(monitoring_id)
    monitoring = UserMonitoring.find(monitoring_id)
    # Aqui você pode adicionar lógicas adicionais como:
    # - Enviar notificações
    # - Gerar relatórios
    # - Atualizar métricas
  end
end