Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
 root "users#index"

 resources :users, only: [:index, :show, :posts,] do
    resources :posts, only: [:index, :new, :posts, :show,]
    resources :comments , :likes
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
