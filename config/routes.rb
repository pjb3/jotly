Rails.application.routes.draw do
  root to: 'home#show'
  resources :jots
  resource :user, except: :destroy, controller: 'user'
  resource :session, only: [:new, :create, :destroy], controller: 'session'
end
