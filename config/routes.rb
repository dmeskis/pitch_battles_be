Rails.application.routes.draw do
  root to: 'welcome#index'
  post 'login', to: 'sessions#create'
  post 'password/forgot', to: 'passwords#forgot'
  post 'password/reset', to: 'passwords#reset'
  
  namespace :api do
    namespace :v1 do
      # Dashboards
      get 'dashboard', to: 'dashboard#show'
      get 'class_dashboard', to: 'class_dashboard#show'
      get 'teacher_dashboard', to: 'teacher_dashboard#index'
      get 'teacher_dashboard/classes/:id', to: 'teacher_dashboard#show'
      # User Endpoints
      get 'users/:id', to: 'users#show'
      get 'users/:id/badges', to: 'users/badges#index'
      get 'users/:id/games', to: 'users/games#index'
      post 'users', to: 'users#create'
      patch 'users', to: 'users#update'
      post 'users/:id/classes', to: 'users/klasses#create'
      delete 'users/:id/classes/:klass_id', to: 'users/klasses#destroy'
      # Game Endpoints
      get 'games/:id', to: 'games#show'
      post 'games', to: 'games#create'
      # Class Endpoints
      post 'classes', to: 'klasses#create'
      delete 'classes/:id', to: 'klasses#destroy'
      # Leaderboard Endpoints
      get 'leaderboards', to: 'leaderboards#index'
    end
  end
end
