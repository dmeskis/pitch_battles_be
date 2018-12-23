Rails.application.routes.draw do
  root to: 'welcome#index'
  post 'login', to: 'sessions#create'
  
  namespace :api do
    namespace :v1 do
      get 'users/:id', to: 'users#show'
      get 'users/:id/badges', to: 'users/badges#index'
      post 'users/:id/class', to: 'users/klasses#create'
      post 'users/:id/games', to: 'games#create'
      get 'users/:id/games', to: 'users/games#index'
      post 'users', to: 'users#create'
      patch 'users/:id', to: 'users#update'
      get 'games/:id', to: 'games#show'
      post 'classes', to: 'klasses#create'
    end
  end
end
