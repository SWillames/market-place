Rails.application.routes.draw do
  root to: 'home#index'

  resources :companies, only: [ :index, :show, :new, :create]
  resources :company_employees, only: [ :show, :new, :create]
end
