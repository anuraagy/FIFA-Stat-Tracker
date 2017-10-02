Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root "games#default"

  resources :games, :except => [:edit, :update]

  resources :leagues, :param => :name do 
    get  :join, :on => :member
    post :add_player, :on => :member
  	resources :seasons, :param => :season_id do

  	end
  end

  get "/myleagues" => "leagues#myleagues"

  get "/table" => "games#table"
  get "/review" => "games#review"
  get "/approve" => "games#approve"
  get "/decline" => "games#decline"
end
