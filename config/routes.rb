# -*- encoding : utf-8 -*-
Politikaopen::Application.routes.draw do
  namespace :admin do
    resources :users do
      member do
        get :activate
        get :reset
        get :login
      end
    end
  end
  namespace :frontend do
    resources :users
    resources :searches
  end
  resources :users do
    member do
      get :print
    end
  end
  resources :sessions do
    collection do
      get :return, :reset_password
      post :reset_password
    end
  end
  resources :forms
  resources :embeds do
    resources :items
  end
  resources :pages, only: :show


  root to: 'pages#home'
end
