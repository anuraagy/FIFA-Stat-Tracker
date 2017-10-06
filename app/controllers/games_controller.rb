class GamesController < ApplicationController
  before_action :authenticate_user!, :except => [:default]
  before_action :find_league, :except => [:default, :review, :approve, :decline]
  before_action :find_season, :except => [:default, :review, :approve, :decline]
  before_action :check_commissioner, :only => [:edit, :update]
  before_action :check_active, :except => [:default, :index, :table, :show, :review, :approve, :decline]

  def index
    if @season.nil?
      @games = @league.current_season.games.order('id ASC')
    else
      @games = @season.games.order('id ASC')
    end
    
    @games = @games.where(:approved => true) unless current_user == @league.commissioner
  end

  def show
    @game = Game.find_by(:game_id => params[:game_id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.game_id = SecureRandom.urlsafe_base64(8)    
    @game.set_reviewer(current_user)
   
    if @game.save
      redirect_to league_season_game_path(@league, @game.season, @game)
    else
      render :new
    end
  end

  def edit
    @game = Game.find_by(:game_id => params[:game_id])
  end

  def update
    @game = Game.find_by(:game_id => params[:game_id])

    if @game.update(game_params)
      redirect_to league_season_game_path(@league, @game.season, @game), :notice => "Game updated"
    else
      render :edit
    end
  end
  
  def review
    @games = current_user.review_needed
  end

  def approve
    @game = Game.find_by(:game_id => params[:game_id])

    if Game.approve(@game, current_user)
      redirect_to review_path, :notice => "The game has been approved"
    else
      redirect_to review_path, :notice => "What do you think you're doing?"
    end
  end

  def decline
    @game = Game.find_by(:game_id => params[:game_id])
    
    if Game.decline(@game, current_user)
      redirect_to review_path, :notice => "The game has been declined"
    else
      redirect_to review_path, :notice => "What do you think you're doing?"
    end
  end


  def destroy
    @game = Game.find_by(:game_id => params[:game_id])
    @game.destroy

    redirect_to games_path
  end


  def table
    @players = @league.players
  end

  def default
  end

  private

  def game_params
    params[:game].permit(:home_user, :away_user, :home_score, :away_score, :winner, :home_penalty_score, :away_penalty_score, :game_id, :season_id)
  end

  def find_season
    if params[:season_id]
      @season = Season.find_by!(:season_id => params[:season_id])
    elsif params[:season_season_id]
      @season = Season.find_by!(:season_id => params[:season_season_id])
    else
      if @league.current_season != nil
        @season = @league.current_season
      else
        redirect_to league_path(@league), :notice => "The season hasn't started yet!"
      end
    end
  end

  def check_active
    unless @season.status == "Active"
      redirect_to league_path(@league), :notice => "This season is over! You must reactivate it to make any changes!"  
    end
  end
end
