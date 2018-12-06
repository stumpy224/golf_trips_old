Rails.application.routes.draw do
  ActiveAdmin.routes(self)

  root 'home#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get 'password_resets/new'
  get 'password_resets/edit'

  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :golfers
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
