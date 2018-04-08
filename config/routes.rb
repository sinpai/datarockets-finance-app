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
    get 'category_history', on: :member, to: 'categories#category_history'
  end
  resources :balance_transactions, except: %i[index show]
  resources :cross_categories_transactions, only: %i[new create]
end
