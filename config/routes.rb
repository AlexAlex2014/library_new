Rails.application.routes.draw do
  root to: 'books#index'
  get 'persons/profile', as: 'user_root'

  get 'persons/profile'
  # get 'subscriptions_create' => 'subscriptions#create'
  get 'likes' => 'likes#create'


  resources :users
  devise_for :users, :path_prefix => 'auth', controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      passwords: 'users/passwords',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :subscriptions # , :only => [:create, :destroy]
  resources :books do
    member do
      post 'toggle'
    end
    # get 'subscriptions_create' => 'subscriptions#create'
    resources :subscriptions
  end

  resources :likes #, :only => [:new, :create, :destroy]

end
