Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :comments, except: %i[new show]
  end
  resources :likes, only: %i[create destroy]
  
  resources :users, only: :show

  get '/users/:id/follows', to: 'follows#follows', as: 'user_follows'
  get '/users/:id/followers', to: 'follows#followers', as: 'user_followers'
  post '/users/:id/follow', to: 'follows#create', as: 'follow_user'
  delete '/users/:id/follow', to: 'follows#destroy', as: 'unfollow_user'

  root to: 'posts#index'
end