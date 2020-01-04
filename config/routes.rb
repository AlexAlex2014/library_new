Rails.application.routes.draw do
  root to: 'public#home'

  get 'categories/index', as: 'user_root'
  get 'subjects' => 'categories#subjects'

  resources :users
  devise_for :users, :path_prefix => 'auth', controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      passwords: 'users/passwords',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :subscriptions, :only => [:index, :create, :destroy]
  resources :likes, :only => [:create, :destroy]
  resources :comments, :only => [:index]
  resources :categories do
    resources :books
  end

  resources :books do
    member do
      post 'toggle'
    end
    member do
      post 'create_star'
      patch 'update_star'
    end
    resources :subscriptions
    resources :likes
    resources :comments, :only => [:new, :create, :destroy]
  end
end
