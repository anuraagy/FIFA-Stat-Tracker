class SeasonsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_league
  before_action :check_commissioner, :except => [:index, :show]

  def index
    @seasons = @league.seasons.all
  end

  def show
    @season = @league.seasons.find_by!(:season_id => params[:season_id])
  end

  def new
    @season = @league.seasons.new
  end

  def create
    @season = @league.seasons.new(season_params)
    @season.season_id = SecureRandom.urlsafe_base64(8)

    if @season.save
      redirect_to manage_league_path(@league), :notice => "You have successfully created the season"
    else
      redirect_to manage_league_path(@league), :notice => @season.errors.messages.values.to_s.gsub!("[","").gsub("]", "").gsub(",", " and").gsub("\"", "")
    end
  end

  def edit
    @season = @league.seasons.find_by!(:season_id => params[:season_id])
  end

  def update
    @season = @league.seasons.find_by!(:season_id => params[:season_id])

    if @season.update(season_params)
      redirect_to manage_league_path(@league), :notice => "You have successfully updatedr the season"
    else
      render :edit
    end
  end

  def destroy
    @season = @league.seasons.find_by!(:season_id => params[:season_id])
    @season.destroy

    redirect_to manage_league_path(@league), :notice => "You have successfully deleted the season"
  end


  def change_status
    @season = Season.find_by!(:season_id => params[:season_id])

    if @season.change_status
      redirect_to manage_league_path(@league), :notice => "Your season's state has been changed"
    else
      redirect_to manage_league_path(@league), :notice => "You can't have two active leagues at the same time!"
    end
  end

  private

  def season_params
    params.require(:season).permit(:start, :end, :status, :season_id, :league_id)
  end
end
