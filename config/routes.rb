Rails.application.routes.draw do
  resources :loans
  resources :users
  resources :guests
  resources :masterlists

  root to: 'visitors#index'
  # get '/auth/:provider/callback' => 'sessions#create'
  get 'auth/facebook/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signup' => 'sessions#new', :as => :signup
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  namespace :api do
    resources :masterlists, only: [:create]
  end

  get '/dashboard', to: 'guests#index', :as => :dashboard

  get '/setup', to: 'setup#index', :as => :setup

  get '/faq', to: 'pages#faq'
  get '/why', to: 'pages#why'
  get '/partner', to: 'pages#partner'

  get "/new_release" => 'partials#new_release', :as => :new_release

  # fallback to new guestlist
  get '/:ref', to: 'guests#new'
end
