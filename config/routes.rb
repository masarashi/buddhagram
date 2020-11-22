Rails.application.routes.draw do

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
    get '/timeline', to: 'users#timeline'
  end

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  get '/post/hashtag/:name', to: 'posts#hashtag'

  resources :relationships, only: [:create, :destroy]
end