Rails.application.routes.draw do
  devise_for :users, controllers: {
     registrations: 'registrations',
     omniauth_callbacks: 'users/omniauth_callbacks'
    }
  root 'items#index'

  resources :omniauth_callbacks do
    member do

    end
  end

  resources :users, only: [:new, :show, :edit, :update] do
    resources :items, only: [:create, :update] do
      member do
        get :myitem
      end
    end
    resources :creditcards, only: [:create]

    member do
      get :logout
      get :identification
      get :show_creditcard
      get :new_creditcard
      get :list
    end

    collection do
      get 'complete'
    end
  end
  resources :items, only: [:new, :index, :show, :destroy, :edit,] do
    collection do
      get 'get_category_children' 
      get 'get_category_grandchildren'
    end
    member do
      get  :buy
      post :pay
    end
  end

  get 'children_category' => 'categories#set_children'

  resources :creditcards, only: [:destroy]
end
