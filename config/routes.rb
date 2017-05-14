Rails.application.routes.draw do
  resources :loans
  resources :users
  root to: 'visitors#index'
  # get '/auth/:provider/callback' => 'sessions#create'
  post 'auth/steam/callback' => 'sessions#create'
  get '/signin' => 'sessions#new', :as => :signin
  get '/signup' => 'sessions#new', :as => :signup
  get '/signout' => 'sessions#destroy', :as => :signout
  get '/auth/failure' => 'sessions#failure'

  get '/dashboard', to: 'loans#index', :as => :dashboard
  get '/setup', to: 'setup#index', :as => :setup

  get '/faq', to: 'pages#faq'
  get '/why', to: 'pages#why'
  get '/partner', to: 'pages#partner'

  get "/new_release" => 'partials#new_release', :as => :new_release
end
