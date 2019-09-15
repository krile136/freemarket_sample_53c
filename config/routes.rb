Rails.application.routes.draw do
  root 'items#index'
  resources :users, only: [:show]    
  resources :items, only: [:index, :show]
end
