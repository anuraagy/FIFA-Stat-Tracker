class LeaguesController < ApplicationController

  before_action :authenticate_user!
  before_action :check_permissions,  :only => [:show, :edit, :update, :destroy]
  before_action :check_commissioner, :only => [:edit, :update, :destroy]

  def index
    @leagues = League.all
  end

  def myleagues
    @leagues = current_user.leagues
  end

  def manage
    @league = League.find_by!(:name => params[:name])
    @season = @league.seasons.new
  end

  def join
    @league = League.find_by!(:name => params[:name])

    redirect_to league_path(@league.name), :notice => "You are already part of this league" if current_user.is_part_of?(@league)   
  end

  def add_player
    @league = League.find_by!(:name => params[:name])

    if params[:password] != @league.password
      redirect_to join_league_path(@league.name), :notice => "The password you entered is incorrect, please try again"
    else
      message = @league.add_player(current_user)
      redirect_to league_path(@league), :notice => message
    end
  end

  def show
    @league = League.find_by!(:name => params[:name])
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)

    if @league.save && @league.add_commissioner(current_user)
      redirect_to league_path(@league)
    else
      render :new
    end
  end

  def edit
    @league = League.find_by!(:name => params[:name])
  end

  def update
    @league = League.find_by!(:name => params[:name])

    if @league.update(league_params)
      redirect_to league_path(@league), :notice => "You have successfully updated the league"
    else
      render :edit
    end
  end

  def destroy
    @league.destroy

    redirect_to root_path, :notice => "Your league has been successfully deleted"
  end

  private

  def league_params
    params[:league][:name] = SecureRandom.urlsafe_base64(8) unless params[:league][:name]
    params.require(:league).permit(:name, :display_name, :password, :sport)
  end

end
