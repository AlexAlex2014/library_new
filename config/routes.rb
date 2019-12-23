Rails.application.routes.draw do
  # root to: 'books#index'
  root to: 'public#home'

  get 'categories/index', as: 'user_root'

  get 'persons/profile'
  get 'subjects' => 'categories#subjects'

  resources :users
  devise_for :users, :path_prefix => 'auth', controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      passwords: 'users/passwords',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :subscriptions # , :only => [:create, :destroy]
  resources :likes #, :only => [:new, :create, :destroy]
  resources :comments
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
    # get 'subscriptions_create' => 'subscriptions#create'
    resources :subscriptions
    resources :likes
    resources :comments
  end
end
