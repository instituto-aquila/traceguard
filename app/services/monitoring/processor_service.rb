# app/services/monitoring/processor_service.rb
module Monitoring
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
        find_or_create_monitoring
        create_pages_visited
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
      raise ProcessingError, "Pages visited are required" unless @params[:pages_visited].present?
    end

    def create_or_update_user
      @user = User.find_or_create_by_email(
        email: @params.dig(:user, :email),
        name: @params.dig(:user, :name),
        ip: @params.dig(:user, :ip)
      )
    end

    def find_or_create_monitoring
      date_threshold = @params[:date].to_date - 7.days
      @monitoring = UserMonitoring.where(user: @user)
        .where('date >= ?', date_threshold)
        .order(date: :desc)
        .first

      unless @monitoring
        @monitoring = UserMonitoring.create!(
          user: @user,
          application_id: @params[:application_id],
          date: @params[:date]
        )
      end
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