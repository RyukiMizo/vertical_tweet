Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get '/home', to:'static_pages#home'
  get '/about', to:'static_pages#about'
  get '/help', to:'static_pages#help'
  get '/contact', to:'static_pages#contact'

  get '/signup', to:'users#new'

  root 'posts#home'
  get '/login', to:'sessions#new'
  post '/login', to:'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :posts, only: [:create, :destroy, :show, :index] do
    collection do
      get "search", "search_js"
    end
    member do
      get "search_index"
    end
  end
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:edit, :update, :new, :create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
