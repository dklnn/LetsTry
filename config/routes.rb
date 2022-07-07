Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts
  root to: 'posts#index', only: %i[index show new create edit update]
  delete '/posts/destroy/:id', to: 'posts#destroy', as: 'destroy'
end
