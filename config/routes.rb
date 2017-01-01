Rails.application.routes.draw do
  devise_for :users
  root "games#default"

  resources :games
end
