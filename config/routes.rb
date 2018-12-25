Rails.application.routes.draw do
  require 'sidekiq/web'
  root to: 'pages#index'
  devise_for :users
  resources :twitter_users
  resources :comments, only: %i[create destroy]
  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
end
