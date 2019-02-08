Rails.application.routes.draw do
  get 'users/new'

  get 'user/new'

  root 'posts#home'
  resources :posts
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
