Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get '/search', to: 'home#search', as: 'search_ad'
  get '/filter', to: 'home#filter', as: 'filter_ad'

  resources :companies, only: [ :index, :show, :new, :create]
  resources :company_employees, only: [:index, :show, :new, :create]
  

  resources :ads, only: [:show, :new, :create]  do
    resource :comments
    resources :sales , only: [:show, :create, :update] 
  end

  resources :sales , only: [:show] do
    resource :comments, only: [:create]
  end

  resources :histories, only: [:index]

end
