Rails.application.routes.draw do
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  patch 'user_hobbies/:id', to: 'users#update_hobbies'

  resources :users, except: [:new] do
    resources :microposts, only: [:index]
  end
  resources :microposts, only: [:create, :destroy]
  post '/hobbies', to: 'hobbies#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end