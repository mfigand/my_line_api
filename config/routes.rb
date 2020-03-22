# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'ping', to: 'ping#ping', as: 'ping'

      post 'authenticate', to: 'authentication#authenticate'

      resources :users
    end
  end
end
