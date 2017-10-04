class GamesController < ApplicationController
  before_action :authenticate_user!, :except => [:default]
  before_action :find_league, :except => [:default, :review, :approve]
  before_action :find_season, :except => [:default, :review, :approve]
  before_action :check_approver, :only => [:approve, :decline]
  def default

  end

  def visualizations

  end

  def review
    @games = current_user.review_needed
  end

  def approve
    @game = Game.find_by(:game_id => params[:game_id])
    @game.reviewed = true
    @game.approved = true
    @game.save
    redirect_to review_path
  end

  def decline
    @game = Game.find_by(:game_id => params[:game_id])
    @game.reviewed = true
    @game.approved = false
    @game.save
    redirect_to review_path
  end

  def index
    @games = []

    if params[:season_id]
      @season = Season.find_by!(:season_id => params[:season_id])
      @games = @season.games.where(:approved => true).order('id ASC')
    else
      @league = League.find_by!(:name => params[:league_name])
      @games = @league.seasons.last.games.where(:approved => true).order('id ASC') unless @league.seasons.count == 0
    end
  end

  def table
    if params[:season_id]
      @season = Season.find_by!(:season_id => params[:season_id])
    else
      @league = League.find_by!(:name => params[:name])
      @season = @league.seasons.last
    end
    @users = User.all
  end

  def show
    @game = Game.find_by(:game_id => params[:game_id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.submitter = current_user.name

    if current_user.name == @game.home_user
      @game.reviewer = @game.away_user
    elsif current_user.name == @game.away_user
      @game.reviewer = @game.home_user
    end

    if current_user.name != @game.home_user && current_user.name != @game.away_user
      @game.errors.add(:base, "You can't submit games for others! Please make sure that one of the players is you.")
      render :new
    else
      if @game.save
        redirect_to league_season_game_path(@league.name, @game.season_id, @game.game_id)
      else
        render :new
      end
    end
  end


  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

  def game_params
    params[:game][:game_id] = SecureRandom.urlsafe_base64(8) if params[:game][:game_id] == ","
    params[:game].permit(:home_user, :away_user, :home_score, :away_score, :winner, :home_penalty_score, :away_penalty_score, :game_id, :season_id)
  end


  def find_league
    if params[:name]
      @league = League.find_by(:name => params[:name])
    elsif params[:league_name]
      @league = League.find_by(:name => params[:league_name])
    end
  end

  def find_season
    if params[:season_id]
      @season = Season.find_by!(:season_id => params[:season_id])
    else
      @season = @league.seasons.last unless @league.seasons.count == 0
    end
  end

  def check_approver
    @game = Game.find_by(:game_id => params[:game_id])

    if @game.reviewer != current_user.name
      redirect_to root_path, :notice => "What do you think you're doing?"
    end
  end
end
