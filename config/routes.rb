Rails.application.routes.draw do
  devise_for :users
  root 'items#index'
  resources :users, only: [:new, :show, :edit]
  resources :items do
  collection do
    get 'get_category_children'
    get 'get_category_grandchildren'
    end
  end
end