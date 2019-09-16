Rails.application.routes.draw do
  root 'items#index'
  resources :users, only: [:show, :edit]
  resources :items, only: [:index, :show]
end
