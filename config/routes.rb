Rails.application.routes.draw do

  get 'users/show'
  root 'posts#index'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  resources :users, only: [:show] do
    member do
      get :following, :followers
    end
  end

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
end
