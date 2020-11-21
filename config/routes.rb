Rails.application.routes.draw do

  root 'posts#index'

  # devise_scope :user do
  #   root "users/sessions#new"
  # end

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

  # get '/:id/timeline', to: 'users#timeline'

  resources :posts do
    resources :comments, only: [:create]
    resources :likes, only: [:create, :destroy]
  end

  resources :relationships, only: [:create, :destroy]
end
