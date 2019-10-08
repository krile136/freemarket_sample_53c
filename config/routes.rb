Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :users do
    collection do
      get 'complete'
    end
  end
  resources :users, only: [:new, :show, :edit] do
    get :logout, on: :member
  end
  resources :items, only: [:new, :index, :show]
end
