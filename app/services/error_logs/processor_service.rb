# app/services/error_logs/processor_service.rb
module ErrorLogs
  class ProcessorService
    class ProcessingError < StandardError; end

    attr_reader :errors
    
    def initialize(params)
      @params = params
      @errors = []
    end
    
    def process
      validate_params!
      ActiveRecord::Base.transaction do
        create_or_update_user
        create_error_log
      end
      true
    rescue StandardError => e
      @errors << e.message
      false
    end
    
    private

    def validate_params!
      raise ProcessingError, "Date is required" unless @params[:date].present?
      raise ProcessingError, "Application ID is required" unless @params[:application_id].present?
      raise ProcessingError, "User email is required" unless @params.dig(:user, :email).present?
      raise ProcessingError, "Code is required" unless @params[:code].present?
      raise ProcessingError, "Erro is required" unless @params[:erro].present?
      raise ProcessingError, "Status ID is required" unless @params[:status_id].present?
      raise ProcessingError, "URL is required" unless @params[:url].present?
    end
    
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