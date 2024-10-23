# app/services/error_logs/processor_service.rb
module ErrorLogs
  class ProcessorService
    attr_reader :errors
    
    def initialize(params)
      @params = params
      @errors = []
    end
    
    def process
      ActiveRecord::Base.transaction do
        create_or_update_user
        create_error_log
      end
      
      ErrorLogWorker.perform_async(@error_log.id)
      true
    rescue StandardError => e
      @errors << e.message
      false
    end
    
    private
    
    def create_or_update_user
      @user = User.find_or_create_by_email(
        email: @params.dig(:user, :email),
        name: @params.dig(:user, :name),
        ip: @params.dig(:user, :ip)
      )
    end
    
    def create_error_log
      @error_log = ErrorLog.create!(
        code: @params[:code],
        erro: @params[:erro],
        backtrace: @params[:backtrace],
        application_id: @params[:application_id],
        url: @params[:url],
        http_method: @params[:http_method],
        date: @params[:date],
        status_id: @params[:status_id],
        user: @user
      )
    end
  end
end