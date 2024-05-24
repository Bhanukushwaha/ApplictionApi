Rails.application.routes.draw do  
  get 'messages/index'
  get 'messages/create'
  # get 'users/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :articles
  resources :posts do
    member do
      post :likes
      post :unlike
      post :create_comments
      get :comments
    end
  end
  resources :users
  resources :messages
  resources :follows do
    get :following, on: :collection
    get :followers, on: :collection
    post :unfollow, on: :collection
  end
  # get 'like/id' => 'articles#like' 
  get '/profile', to: 'users#profile'
  post '/auth/login', to: 'authentication#login'
  post '/users/password_update', to: 'users#password_update'
end
