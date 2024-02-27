Rails.application.routes.draw do
  get 'home/index'
  # get 'users/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/users', to: 'users#create'
  post '/auth/login', to: 'authentication#login'
  put '/users/password_update', to: 'users#password_update'
end
