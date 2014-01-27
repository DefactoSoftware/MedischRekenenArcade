MedischRekenenArcade::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :activities

  devise_for :users

  resources :friendships, only: [:create, :destroy]

  root to: "home#index"

  resources :users, only: [:show,:index] do
    resources :statistics, only: [:index]
  end

  resources :feedback_reports, only: [:create]

  resources :leaderboards, only: [:index]

  get 'practice', to: 'problems#index'

  resources :answers, only: [:create]

  resources :challenges, only: [:index, :show]
end
