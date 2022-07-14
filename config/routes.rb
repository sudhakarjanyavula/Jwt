Rails.application.routes.draw do
  default_url_options :host => 'localhost:3000'
  get 'posts/index'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :likes
  resources :posts
  resources :comments

  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
  post '/auth/logout', to: 'authentication#logout'
  resources :relationships, only: [:create, :destroy]
end
