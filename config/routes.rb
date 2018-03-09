Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'home_page#show'
  resources :transactions do
    collection do
      get 'search' => 'transactions#search'
      post 'search' => 'transactions#search'
    end
  end
end
