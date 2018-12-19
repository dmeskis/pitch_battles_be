Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'users/:id', to: 'users#show'
      post 'users/:id/games', to: 'games#create'
      post 'users', to: 'users#create'
      patch 'users/:id', to: 'users#update'
    end
  end
end
