Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts do
    resources :comments, only: [:new, :create, :destroy]
  end

  root to: 'posts#index'
  delete '/posts/destroy/:id', to: 'posts#destroy', as: 'destroy_post'
end
