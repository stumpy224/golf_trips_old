Rails.application.routes.draw do
  namespace :admin do
    resources :golfers
    resources :courses
    resources :holes
    resources :lodging_types
    resources :lodgings
    resources :outings
    resources :outing_golfers
    resources :teams
    resources :scores
    resources :users

    get 'outings/:id/get_dates', to: 'outings#get_dates', as: 'get_outing_dates'
    get 'outings/:id/teams/:team_date/generate', to: 'teams#generate', as: 'generate_teams'

    root to: "golfers#index"
  end

  root 'home#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'password_resets/new'
  get 'password_resets/edit'

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :outings, only: [:show]
  resources :users
end
