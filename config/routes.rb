Rails.application.routes.draw do
  root 'prototypes#index'
  devise_for :users
  resources :prototypes, only: [:index, :show, :new]
end
