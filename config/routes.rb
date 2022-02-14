Rails.application.routes.draw do
  root "posts#index"

  resources :posts, only: %i[index]
  resources :users, only: %i[index]
end
