Rails.application.routes.draw do
  root 'search#index'

  get '/search', to: 'search#index'
  get '/search/search', to: 'search#search'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  resources :users, only: %i[index show] do
    member do
      get :following, :followers
    end
    get '/timeline', to: 'users#timeline'
  end

  get '/posts/new_post', to: 'posts#new_post'
  get '/posts/hashtag/:name', to: 'posts#hashtag'
  get '/posts/search', to: 'posts#search'
  get '/posts/latest', to: 'posts#latest'
  post 'posts/new', to: 'posts#new'
  # post 'posts/:id/edit', to: 'posts#edit'
  # post 'posts/confirm', to: 'posts#confirm'

  resources :posts do
    resources :comments, only: %i[create destroy]
    resources :likes, only: %i[create destroy]
  end

  resources :relationships, only: %i[create destroy]
  resources :maps, only: [:index]

  get '/spots/search_location'
  get '/spots/geocoding_search', to: 'spots#geocoding_search'
  get '/spots/search', to: 'spots#search'
  resources :spots

  resources :statues
end
