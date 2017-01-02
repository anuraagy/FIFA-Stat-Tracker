Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root "games#default"

  resources :games, :except => [:edit, :update]
  get "/table" => "games#table"
end
