Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :users, only: [:new, :show, :edit]
  resources :items, only: [:index, :show]
  
end
