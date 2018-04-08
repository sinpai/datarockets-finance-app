Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'home_page#show'
  resources :transactions, only: %i[index] do
    collection do
      post 'search', to: 'transactions#search'
    end
  end
  resources :categories, except: :show do
    get 'add_money', on: :member, to: 'category_transactions#new'
    post 'update_balance', on: :member, to: 'category_transactions#create'
  end
  resources :balance_transactions, except: %i[index show]
end
