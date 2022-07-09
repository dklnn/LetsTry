Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts do
    resources :comments
  end

  root to: 'posts#index'
  delete '/posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post'
  delete '/posts/:post_id/comments/:id', to: 'comments#destroy', as: 'destroy_post_comment'
  patch '/posts/:post_id/comments/:id', to: 'comments#update', as: 'update_post_comment'
  #put '/posts/:post_id/comments/:id', to: 'comments#update', as: 'update_post_comment'
end
