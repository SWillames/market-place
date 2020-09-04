Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'

  resources :companies, only: [ :index, :show, :new, :create]
  resources :company_employees, only: [:index, :show, :new, :create]
end
