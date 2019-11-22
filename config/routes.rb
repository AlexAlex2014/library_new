Rails.application.routes.draw do

  get 'persons/profile'
  devise_for :users

  root to: 'books#index'
  get 'persons/profile', as: 'user_root'

  resources :books

end
