Rails.application.routes.draw do
  get 'posts/posts'
  get 'home/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :users, only: %w[:index :show] do
    resources :posts, only: %w[:index :show]
  end
  # Defines the root path route ("/")
  # root "articles#index"
  root 'home#home'
end
