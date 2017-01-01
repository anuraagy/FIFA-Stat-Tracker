class GamesController < ApplicationController
  def default

  end

  def index
    @games = Game.all
  end

  def show
    @game = Game.find(params[:id])
  end

  def new
    @game = Game.new
  end

  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(game_params)

    if @game.save
      redirect_to @game
    else
      render :new
    end
  end

  def update
    @game = Game.find(params[:id])

    if @game.update(game_params)
      redirect_to @game
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

  private

  def game_params
    params[:game].permit(:home_user, :away_user, :home_score, :away_score, :winner)
  end

end
