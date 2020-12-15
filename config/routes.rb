Rails.application.routes.draw do

  root 'spots#index'

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

  post 'posts/new', to: 'posts#new'
  # post 'posts/:id/edit', to: 'posts#edit'
  # post 'posts/confirm', to: 'posts#confirm'
  get '/post/hashtag/:name', to: 'posts#hashtag'
  get '/posts/search', to: 'posts#search'

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
  resources :maps, only: [:index]

  get '/spots/search_location'
  get '/spots/get_address', to: 'spots#get_address'
  get '/spots/search', to: 'spots#search'
  resources :spots
end
