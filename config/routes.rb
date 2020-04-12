# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'ping', to: 'ping#ping', as: 'ping'

      post 'authenticate', to: 'authentication#authenticate'

      get 'users/:author_id/author_index', to: 'timelines#author_index', as: 'author_index'
      get 'users/:protagonist_id/protagonist_index', to: 'timelines#protagonist_index', as: 'protagonist_index'

      resources :users do
        resources :timelines, only: %i[create show update destroy]
      end
    end
  end
end
