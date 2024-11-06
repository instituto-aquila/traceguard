# app/controllers/api/v1/error_logs_controller.rb
module Api
  module V1
    class ErrorLogsController < BaseController
      def create
        if valid_error_log_params?
          job_params = JSON.parse(error_log_params.to_h.to_json)
          ErrorLogWorker.perform_async(job_params)
          render json: { status: 'success', message: 'Error log data is being processed' }, status: :accepted
        else
          render json: { errors: ['Invalid parameters'] }, status: :unprocessable_entity
        end
      end

      def index     
        @q = ErrorLog
            .by_code(params[:code])
            .by_application(params[:application_id])

        relations = [application: { except: [:api_key] }]

        render json: ActiveSupport::JSON.decode(@q.to_json(include: relations)), status: 200

        return

        render json: paginate_return(params, @q, relations)
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

      def valid_error_log_params?
        error_log_params[:application_id].present? &&
        error_log_params[:date].present? &&
        error_log_params[:code].present? &&
        error_log_params[:erro].present? &&
        error_log_params[:status_id].present? &&
        error_log_params[:url].present? &&
        error_log_params.dig(:user, :email).present?
      end
    end
  end
end