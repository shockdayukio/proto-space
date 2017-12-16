Rails.application.routes.draw do
  root 'prototypes#index'
  devise_for :users
  resources :users, only: [:show, :edit, :update]

  namespace :prototypes do
    resources :popular, only: :index
    resources :newest, only: :index
  end

  resources :prototypes do
    resources :comments, only: :create
  end

  resources :likes, only:[:create, :destroy]
  resources :tags, only:[:index, :show]
end
