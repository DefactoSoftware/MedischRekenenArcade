MedischRekenenArcade::Application.routes.draw do
  devise_for :users

  resources :friendships, only: [:create, :destroy]

  root to: "home#index"

  resources :users, only: [:show,:index]

  resources :leaderboards, only: [:index]

  get 'practice', to: 'problems#index'

  resources :answers, only: [:create]
end
