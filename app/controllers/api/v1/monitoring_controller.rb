# app/controllers/api/v1/monitoring_controller.rb
module Api
  module V1
    class MonitoringController < BaseController
      def create
        if valid_monitoring_params?
          job_params = JSON.parse(monitoring_params.to_h.to_json)
          MonitoringWorker.perform_async(job_params)
          render json: { status: 'success', message: 'Monitoring data is being processed' }, status: :accepted
        else
          render json: { errors: ['Invalid parameters'] }, status: :unprocessable_entity
        end
      end

      private

      def monitoring_params
        params.permit(
          :application_id,
          :date,
          user: [:name, :email, :ip],
          pages_visited: [:page_url, :start_time, :end_time, :duration_seconds, :publication_id, :publication_title]
        )
      end

      def valid_monitoring_params?
        monitoring_params[:application_id].present? &&
        monitoring_params[:date].present? &&
        monitoring_params.dig(:user, :email).present? &&
        monitoring_params[:pages_visited].present?
      end
    end
  end
end