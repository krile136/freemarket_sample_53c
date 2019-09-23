Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
  }
  root 'items#index'
  resources :users, only: [:new, :show, :edit]
  resources :items, only: [:new, :index, :show]

end
