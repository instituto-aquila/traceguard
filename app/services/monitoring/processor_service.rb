# app/services/monitoring/processor_service.rb
module Monitoring
  class ProcessorService
    attr_reader :errors
    
    def initialize(params)
      @params = params
      @errors = []
    end
    
    def process
      ActiveRecord::Base.transaction do
        create_or_update_user
        create_monitoring
        create_pages_visited
      end
      
      MonitoringWorker.perform_async(@monitoring.id)
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
    
    def create_monitoring
      @monitoring = UserMonitoring.create!(
        user: @user,
        application_id: @params[:application_id],
        date: @params[:date]
      )
    end
    
    def create_pages_visited
      pages = @params[:pages_visited].map do |page|
        {
          user_monitoring_id: @monitoring.id,
          page_url: page[:page_url],
          start_time: page[:start_time],
          end_time: page[:end_time],
          duration_seconds: page[:duration_seconds],
          publication_id: page[:publication_id],
          publication_title: page[:publication_title]
        }
      end
      
      PagesVisited.insert_all(pages)
    end
  end
end