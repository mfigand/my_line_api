# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'ping', to: 'ping#ping', as: 'ping'

      post 'authenticate', to: 'authentication#authenticate'

      get 'timelines/author_index', to: 'timelines#author_index',
                                    as: 'timelines_author_index'
      get 'timelines/protagonist_index', to: 'timelines#protagonist_index',
                                         as: 'timelines_protagonist_index'

      get 'users/:teller_id/stories/teller_index', to: 'stories#teller_index',
                                                   as: 'stories_teller_index'
      get 'users/:protagonist_id/stories/protagonist_index', to: 'stories#protagonist_index',
                                                             as: 'stories_protagonist_index'

      resources :users do
        resources :roles
      end

      resources :timelines, only: %i[create show update destroy] do
        resources :stories, only: %i[index create show update destroy]
      end
    end
  end
end
