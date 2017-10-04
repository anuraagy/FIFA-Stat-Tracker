Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations" }
  root "games#default"

  resources :leagues, :param => :name do 
    get  :join,       :on => :member
    post :add_player, :on => :member
    get  :table,      :on => :member, :controller => :games

    resources :games, :param => :game_id do 
    end

  	resources :seasons, :param => :season_id do
      resources :games, :param => :game_id do 

      end
  	end
  end

  get "/myleagues" => "leagues#myleagues"

  get "/table" => "games#table"
  get "/review" => "games#review"
  get "/approve" => "games#approve"
  get "/decline" => "games#decline"
end
