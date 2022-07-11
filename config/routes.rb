Rails.application.routes.draw do
  devise_for :users

  resources :posts do
    resources :comments, except: %i[new show]
  end
  resources :likes, only: %i[new create destroy]

  root to: 'posts#index'

  delete '/posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post'

  delete '/posts/:post_id/comments/:id', to: 'comments#destroy', as: 'destroy_post_comment'
  patch  '/posts/:post_id/comments/:id', to: 'comments#update', as: 'update_post_comment'

  get  'users/:id', to: 'users#show', as: 'user'
  post '/users/:id/follow', to: 'users#follow', as: 'follow_user'
  post '/users/:id/unfollow', to: 'users#unfollow', as: 'unfollow_user'
end
