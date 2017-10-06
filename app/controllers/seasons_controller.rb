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

  def change_status
    @season = Season.find_by!(:season_id => params[:season_id])
    @league = @season.league
    @count = @league.seasons.where(:status => "Active").count

    if @season.status == "Active"
      @season.status = "Inactive"

      if @season.save
        redirect_to manage_league_path(@league), :notice => "You have successfully updated your league status"
      else
        redirect_to manage_league_path(@league), :notice => "Something went wrong, please try again later"
      end
    elsif @season.status == "Inactive" && @league.seasons.where(:status => "Active").count == 0
      @season.status = "Active"

      if @season.save
        redirect_to manage_league_path(@league), :notice => "You have successfully updated your league status"
      else
        redirect_to manage_league_path(@league), :notice => "Something went wrong, please try again later"
      end
    else
      redirect_to manage_league_path(@league), :notice => "You already have a league active"
    end
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
      render :new
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

  private

  def season_params
    params.require(:season).permit(:start, :end, :status, :season_id, :league_id)
  end
end
