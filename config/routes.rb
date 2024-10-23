require 'sidekiq/web'

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  root to: redirect('/api-docs')

  namespace :api do
    namespace :v1 do
      resources :monitoring
      resources :error_logs
    end
  end
  
  mount Sidekiq::Web => '/sidekiq'
end
