Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users', to: 'users#index'
  get '/users/:name', to: 'users#show'
  post '/users', to: 'users#create'
  put '/users/:name', to: 'users#update'
  get '/pickup', to: 'users#pickup'
  get '/message', to: 'users#message'
end
