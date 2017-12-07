Rails.application.routes.draw do
  root 'prototypes#index'
  devise_for :users
  resources :users, only: [:show, :edit, :update]
  resources :prototypes
  resources :likes, only:[:create, :destroy]
end
