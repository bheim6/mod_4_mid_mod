Rails.application.routes.draw do
  root to: "links#index"

  resources :links, only: [:index]

  namespace :api do
    namespace :v1 do
      resources :links, only: [:create]
    end
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
end
