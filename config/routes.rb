Rails.application.routes.draw do
  root to: "links#index"

  resources :links, only: [:index, :new, :create, :edit, :update]
  resources :users, only: [:new, :create]

  namespace :api do
    namespace :v1 do
      resources :links
    end
  end

  get 'login_router', to: 'sessions#router'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
end
