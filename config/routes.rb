Rails.application.routes.draw do
  resources :jots
  resources :home
  resource :users
  resource :session

end
