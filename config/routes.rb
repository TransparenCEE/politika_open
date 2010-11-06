Politikaopen::Application.routes.draw do |map|
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
    resources :pages
  end
  resources :users do
    member do
      get :print
    end
  end
  resources :sessions do
    collection do
      get :return
    end
  end
  resources :forms
  resources :embeds do
    resources :items
  end
  resources :pages

  root :to => "frontend/users#index"
end
