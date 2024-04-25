Rails.application.routes.draw do
  get 'post/index'
  get 'post/show'
  # get 'users/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  # root "articles#index"
  resources :articles
  resources :users
  # post '/users', to: 'users#create'
  post '/auth/login', to: 'authentication#login'
  put '/users/password_update', to: 'users#password_update'
end
