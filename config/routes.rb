Rails.application.routes.draw do  
  # get 'users/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :articles
  resources :posts do
    member do
      post :likes
      delete :unlike
      post :create_comments
    end
  end
  resources :users
  # get 'like/id' => 'articles#like'
  # post '/users', to: 'users#create'
  post '/auth/login', to: 'authentication#login'
  post '/users/password_update', to: 'users#password_update'
end
