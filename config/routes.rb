Rails.application.routes.draw do
  resources :jots do
  # read up on this member thing
    member do
      post :like
      post :unlike
    end
  end

  resources :home
  resource :users
  resource :session

end
