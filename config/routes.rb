MedischRekenenArcade::Application.routes.draw do
  use_doorkeeper
  devise_for :admin_users, ActiveAdmin::Devise.config

  mount Raddocs::App => "/docs"

  ActiveAdmin.routes(self)
  resources :activities

  devise_for :users, controllers: {:registrations => "registrations"}

  resources :friendships, only: [:create, :destroy]

  root to: "home#index"

  resources :users, only: [:show,:index] do
    resources :statistics, only: [:index]
    resources :challenges, only: [:index, :show], controller: "my_challenges"
  end

  resources :badges, only: [:index]

  resources :feedback_reports, only: [:create]

  resources :leaderboards, only: [:index]

  get 'practice', to: 'problems#index'

  resources :answers, only: [:create]

  resources :challenges, only: [:index, :show]

  resources :user_groups, only: [:create]

  resources :notifications, only: [:index]

  resources :head_to_head_challenges, only: [:show, :index]

  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :problems, only: :index
      resources :answers, only: :create

      namespace :tincan do
        resources :user_challenges, only: :index
      end
    end
  end
end
