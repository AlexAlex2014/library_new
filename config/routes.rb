Rails.application.routes.draw do
  root to: 'books#index'
  get 'persons/profile', as: 'user_root'

  get 'persons/profile'

  resources :users
  devise_for :users, :path_prefix => 'auth', controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      confirmations: 'users/confirmations',
      passwords: 'users/passwords',
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :books

end
