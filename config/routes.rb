Rails.application.routes.draw do
  resources :jots
  resources :home
  resources :users
  resource :session

end
