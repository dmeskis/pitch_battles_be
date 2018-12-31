Rails.application.routes.draw do
  root to: 'welcome#index'
  post 'login', to: 'sessions#create'
  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'
  
  namespace :api do
    namespace :v1 do
      get 'dashboard', to: 'dashboard#show'
      get 'users/:id', to: 'users#show'
      get 'users/:id/badges', to: 'users/badges#index'
      post 'users/:id/classes', to: 'users/klasses#create'
      delete 'users/:id/classes/:klass_id', to: 'users/klasses#destroy'
      post 'games', to: 'games#create'
      get 'users/:id/games', to: 'users/games#index'
      post 'users', to: 'users#create'
      patch 'users', to: 'users#update'
      get 'games/:id', to: 'games#show'
      post 'classes', to: 'klasses#create'
      delete 'classes/:id', to: 'klasses#destroy'
    end
  end
end
