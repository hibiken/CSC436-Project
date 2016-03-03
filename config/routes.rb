require "api_constraints"

Rails.application.routes.draw do
  root 'home#show'

  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :users, only: [:index, :show, :create, :update] do
        resources :posts, only: [:show, :create, :update]
      end
      resources :posts, only: [:index]
      resources :sessions, only: [:create, :destroy]
    end
  end
end
