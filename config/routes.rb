Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions:      "users/sessions",
    passwords:     "users/passwords",
    registrations: "users/registrations"
  }

  namespace :admin do
    root "home#index"
    resources :conferences,   only: [ :show, :create, :destroy, :edit, :update ]
    resources :days,          only: [ :edit, :update ]
    resources :tracks,        only: [ :edit, :update ]
    resources :slots,         only: [ :create, :destroy, :edit, :update ]
    resources :presentations, only: [ :show, :create, :destroy, :edit, :update ]
    resources :users,         only: [ :destroy, :edit, :update ]
  end

  root to: "conferences#index"
  resources :conferences, only: [ :show, :index ]
  resources :days, only: [ :show ]
  resources :tracks, only: [ :show ]
  resources :slots, only: [ :show ]
  resources :presentations, only: [ :show ]
  resources :evaluations, only: [ :update ]
end
