Rails.application.routes.draw do
  resources :users
  post '/auth/login', to: 'authentication#login'
  get '/*a', to: 'application#not_found'
  post '/auth/logout', to: 'authentication#logout'
end
