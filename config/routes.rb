Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :users, only: [:new, :show]
  resources :items, only: [:index, :show]
end
