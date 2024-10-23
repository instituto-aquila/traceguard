# app/controllers/api/v1/base_controller.rb
module Api
  module V1
    class BaseController < ApplicationController
      include ActionController::HttpAuthentication::Token::ControllerMethods
      
      before_action :authenticate
      
      private
      
      def authenticate
        authenticate_or_request_with_http_token do |token, options|
          JWT.decode(token, Rails.application.credentials.secret_key_base)
        rescue JWT::DecodeError
          head :unauthorized
        end
      end
    end
  end
end