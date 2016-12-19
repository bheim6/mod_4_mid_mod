Rails.application.routes.draw do
  root to: "links#index"

  resources :links, only: [:index]
  resources :users, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create]
    end
  end

  get 'login_router', to: 'sessions#router'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  get 'signup', to: 'users#new'
end
