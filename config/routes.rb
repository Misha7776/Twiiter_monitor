Rails.application.routes.draw do
  root to: 'pages#index'
  devise_for :users
  resources :twitter_users do
    collection do
      get :export_to_exel
    end
  end
  resources :comments, only: %i[create destroy]
end
