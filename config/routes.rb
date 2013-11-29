MedischRekenenArcade::Application.routes.draw do
  devise_for :users

  resources :friendships, only: [:create, :delete]

  root to: "home#index"

  resources :users, only: [:show,:index]

  resources :leaderboards, only: [:show, :index]

  get 'practice', to: 'problems#show'

  resources :answers, only: [:create]
end
