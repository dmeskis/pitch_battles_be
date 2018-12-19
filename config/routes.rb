Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      get 'users/:id', to: 'users#show'
      post 'users', to: 'users#new'
      patch 'users/:id', to: 'users#update'
    end
  end
end
