Rails.application.routes.draw do
  namespace :admin do
    resources :outings
    resources :outing_golfers
    resources :teams
    resources :scores
    resources :golfers
    resources :courses
    resources :holes
    resources :lodging_types
    resources :lodgings
    resources :users
    resources :user_email_opt_outs
    resources :admin_controls
    resources :email_logs

    get 'outings/:id/get_dates', to: 'outings#get_dates', as: 'get_outing_dates'
    get 'outings/:id/teams/:team_date/generate', to: 'teams#generate', as: 'generate_teams'
    get 'outings/:id/teams/:team_date/email', to: 'teams#email_registered_users', as: 'email_registered_users'

    root to: "outings#index"
  end

  root 'home#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'password_resets/new'
  get 'password_resets/edit'

  get '/users/:uuid/unsubscribe/:email_template', to: 'users#unsubscribe', as: 'user_unsubscribe'
  post '/user_email_prefs', to: 'users#email_prefs', as: 'user_email_prefs'

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :outings, only: [:show]
  resources :users
end
