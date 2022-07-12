Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :comments, except: %i[new show]
  end
  resources :likes, only: %i[new create destroy]

  get '/users/:id/followings', to: 'follows#followings', as: 'user_followings'
  get '/users/:id/followers', to: 'follows#followers', as: 'user_followers'
  post '/users/:id/follow', to: 'follows#create', as: 'follow_user'
  delete '/users/:id/follow', to: 'follows#destroy', as: 'unfollow_user'

  root to: 'posts#index'

  delete '/posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post'

  delete '/posts/:post_id/comments/:id', to: 'comments#destroy', as: 'destroy_post_comment'
  patch  '/posts/:post_id/comments/:id', to: 'comments#update', as: 'update_post_comment'

  get  'users/:id', to: 'users#show', as: 'user'
end
