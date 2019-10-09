Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'items#index'

  resources :users, only: [:new, :show, :edit] do
    member do
      get :logout
      get :identification
    end

    collection do
      get 'complete'
    end
  end
  resources :items, only: [:new, :index, :show] do 
    collection do
      get 'category_children' 
      get 'category_grandchildren'
    end
  end
end
