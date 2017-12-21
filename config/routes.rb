Rails.application.routes.draw do

  root :to => 'main#index'

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get '/login', :to => 'sessions#new', :as => 'login'
  post '/login', :to => 'sessions#create'
  delete '/logout', :to => 'sessions#destroy'

  namespace :platform do
    resources :items, only: [:index, :edit, :update]
    resources :orders, only: [:index]
    resources :dashboard, only: [:index]
    resources :users, only: [:index, :edit, :update]
  end

  namespace :api do
    namespace :v1 do
      get '/search', to: 'search#index'
    end
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :edit, :new, :create, :update]
    resources :analytics, only: [:index]
    resources :stores, only: [:index, :update]
    resources :employees, only: [:index, :update]
  end

  resources :users , only: [:new, :create, :edit, :update]

  resources :orders, only: [:index, :new, :show, :update]

  resources :dashboard, only: [:index]

  get '/cart', :to => 'carts#index', :as => 'cart'

  resources :items, only: [:index, :show]

  resources :carts, only: [:index, :create, :destroy]

  patch '/cart', :to => 'carts#update'

  delete '/cart', :to => 'carts#destroy'
  resources :carts, only: [:index, :create, :destroy]

  resources :categories, only: [:show], param: :category

  namespace :user do
    resources :stores, only: [:index, :edit, :update]
  end

  resources :stores, only: [:index, :new, :create]

  get "/:store", to: "stores#show", as: :store

  resources :charges, only: [:new, :create]

end
