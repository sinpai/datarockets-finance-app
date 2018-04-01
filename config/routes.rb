Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'home_page#show'
  resources :transactions, only: %i[index] do
    collection do
      post 'search' => 'transactions#search'
    end
  end
  resources :categories, except: :show
  resources :balance_transactions, except: %i[index show]
end
