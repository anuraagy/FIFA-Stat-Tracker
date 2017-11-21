Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "registrations",  :omniauth_callbacks => "users/omniauth_callbacks" }
  root "games#default"

  resources :leagues, :param => :name do 
    get  :join,       :on => :member
    post :add_player, :on => :member
    get  :table,      :on => :member, :controller => :games
    get  :manage,     :on => :member

    resources :games, :param => :game_id do 
    end

  	resources :seasons, :param => :season_id do
      post :change_status, :on => :member
      get  :index, :on => :member, :controller => :games, :action => :table

      resources :games, :param => :game_id do 

      end
  	end
  end

  get "/myleagues" => "leagues#myleagues"

  get "/table" => "games#table"
  get "/review" => "games#review"
  post "/approve" => "games#approve"
  post "/decline" => "games#decline"
end
