Rails.application.routes.draw do
  root 'articles#index'
  devise_for :users
  resources :articles, only: [:index, :show]
  resources :events, only: [:index, :show]
  resources :payments, only: [:index, :create]

  namespace :api, defaults: { format: :json },
                             constraints: { subdomain: 'api' }, path: '/'  do
   scope module: :v1,
      constraints: ApiConstraints.new(version: 1, default: true) do
     # We are going to list our resources here
     resources :users, only: [:show, :create, :update, :destroy]
     resources :sessions, only: [:create, :destroy]
     resources :donations, only: [:show, :index, :create]
     resources :contacts, only: [:show, :index]
   end
 end
end
