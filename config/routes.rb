MedischRekenenArcade::Application.routes.draw do
  resources :activities

  devise_for :users

  resources :friendships, only: [:create, :destroy]

  root to: "home#index"

  resources :users, only: [:show,:index] do
    resources :statistics, only: [:index]
  end

  resources :leaderboards, only: [:index]

  get 'practice', to: 'problems#index'

  resources :answers, only: [:create]

  resources :challenges, only: [:index, :show]
end
