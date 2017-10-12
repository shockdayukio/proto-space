Rails.application.routes.draw do
  resources :prototypes, only: [:index, :show, :new]
end
