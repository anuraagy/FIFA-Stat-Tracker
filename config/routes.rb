Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root "games#default"

  resources :games, :except => [:edit, :update]
  get "/table" => "games#table"
  get "/review" => "games#review"
  get "/approve" => "games#approve"
  get "/decline" => "games#decline"
end
