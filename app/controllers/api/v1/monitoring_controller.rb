# app/controllers/api/v1/monitoring_controller.rb
module Api
  module V1
    class MonitoringController < BaseController
      def create
        monitoring_service = Monitoring::ProcessorService.new(monitoring_params)
        
        if monitoring_service.process
          render json: { status: 'success' }, status: :created
        else
          render json: { errors: monitoring_service.errors }, status: :unprocessable_entity
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
    end
  end
end