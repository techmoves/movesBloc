Rails.application.routes.draw do
  # devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  devise_for :users, skip: [:sessions]
  as :user do
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    get 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end
  # Defines the root path route ("/")
  root "users#index"

  resources :users, only: [:index, :show, :destroy, :create] do
    resources :posts do
      resources :comments , :likes, :destroy
    end
  end
  
end