Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users
  post 'login', to: 'users#login'
  post 'profile', to: 'users#profile'
  post 'update', to: 'users#update'
end
