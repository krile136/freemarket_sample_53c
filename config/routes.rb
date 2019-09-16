Rails.application.routes.draw do
  devise_for :users
  # root 'user#new'
  resources :users
  devise_scope :user do
    root :to => "devise/sessions#new"
  end
end
