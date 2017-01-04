class GamesController < ApplicationController
  before_action :authenticate_user!, :except => [:default]

  def default

  end

  def visualizations

  end

  def review
    @games = current_user.review_needed
  end

  def approve
    @game = Game.find(params[:game])
    @game.reviewed = true
    @game.save
    redirect_to games_path
  end

  def index
    @games = Game.where(:reviewed => true).order('id ASC')
  end

  def table
    @users = User.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def create
    @game = Game.new(game_params)
    @game.submitter = current_user.name

    if current_user.name == @game.home_user
      @game.reviewer = @game.away_user
    else
      @game.reviewer = @game.home_user
    end

    if @game.save
      @home_user = User.find_by(:name => @game.home_user)
      @home_user.goals_for += @game.home_score
      @home_user.goals_against += @game.away_score
      @away_user = User.find_by(:name => @game.away_user)
      @away_user.goals_for += @game.away_score
      @away_user.goals_against += @game.home_score

      if @game.home_score > @game.away_score || (@game.home_penalty_score? && @game.home_penalty_score > @game.away_penalty_score)
        @home_user.points += 3
        @home_user.win_count += 1
        @away_user.loss_count += 1
      else
        @away_user.points += 3
        @away_user.win_count += 1
        @home_user.loss_count += 1
      end
      @home_user.save
      @away_user.save
      redirect_to @game
    else
      render :new
    end
  end


  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

  def game_params
    params[:game].permit(:home_user, :away_user, :home_score, :away_score, :winner, :home_penalty_score, :away_penalty_score)
  end

end
