Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root 'items#index'

  resources :users, only: [:new, :show, :edit, :update] do
    resources :items, only: [:create]
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
      get 'get_category_children' 
      get 'get_category_grandchildren'
    end
  end
end
