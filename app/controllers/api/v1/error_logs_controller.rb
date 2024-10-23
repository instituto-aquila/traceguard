# app/controllers/api/v1/error_logs_controller.rb
module Api
  module V1
    class ErrorLogsController < BaseController
      def create
        error_service = ErrorLogs::ProcessorService.new(error_log_params)
        
        if error_service.process
          render json: { status: 'success' }, status: :created
        else
          render json: { errors: error_service.errors }, status: :unprocessable_entity
        end
      end
      
      private
      
      def error_log_params
        params.permit(
          :code,
          :erro,
          :backtrace,
          :application_id,
          :url,
          :http_method,
          :date,
          :status_id,
          user: [:name, :email, :ip]
        )
      end
    end
  end
end