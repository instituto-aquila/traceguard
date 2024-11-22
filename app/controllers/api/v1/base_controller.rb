# app/controllers/api/v1/base_controller.rb
module Api
  module V1
    class BaseController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      
      before_action :authenticate
      
      private
      
      def authenticate
        authenticate_or_request_with_http_token do |token, options|
          @application = Application.find_by(api_key: token)
          @application.present?
        end
      end

      def paginate_return(params, selected_fields, total, relations = nil) # rubocop:todo Metrics/AbcSize, Naming/MethodParameterName
        # rubocop:enable Naming/MethodParameterName
        page = params[:page].to_i || 0
        per_page = params[:per_page] || 25
        per_page = per_page.to_i
    
        # q.sorts = [params[:order]] if params[:order].present?
        # q.sorts = ['name asc'] if !params[:order].present?
    
        list = selected_fields.paginate(page: page + 1, per_page: per_page)
        if relations
          list = ActiveSupport::JSON.decode(list.to_json(include: relations))
        end
    
        { results: list,
          paginate: { page: page, per_page: per_page, total: total, total_page: (total.to_f / per_page).ceil,
                      start: (per_page * (page + 1)) - per_page + 1 } }
      end

    end
  end
end