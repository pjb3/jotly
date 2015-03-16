Rails.application.routes.draw do
  root to: 'home#show'
  resources :jots do
    member do
      post :like
      post :unlike
    end
  end
  resources :followers, only: [:create, :destroy]
  resource :user, except: :destroy, controller: 'user'
  resource :session, only: [:new, :create, :destroy], controller: 'session'
end
