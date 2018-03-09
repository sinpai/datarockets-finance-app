Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: 'home_page#show'
  resources :transactions do
    collection do
      match 'search' => 'transactions#search', via: %i[get post]
    end
  end
end
