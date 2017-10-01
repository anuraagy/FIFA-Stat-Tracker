class LeaguesController < ApplicationController

  before_action :check_permissions, :only => [:new, :create, :show, :edit, :update, :destroy]

  def index
    @leagues = League.all
  end

  def myleagues
    @leagues = current_user.leagues
  end

  def show
    @league = League.find_by!(:name => params[:name])
  end

  def new
    @league = League.new
  end

  def create
    @league = League.new(league_params)

    if @league.save
      redirect_to @league
    else
      render :new
    end
  end

  def join
    @league = League.find_by!(:name => params[:name])
  end

  def edit
    @league = League.find_by!(:name => params[:name])
  end

  def update
    @league = League.find_by!(:name => params[:name])

    if @league.update(league_params)
      redirect_to @league
    else
      render :edit
    end
  end

  def destroy
    @league.destroy

    redirect_to :index
  end

  private

  def league_params
    params.require(:league).permit(:name, :display_name, :password, :sport)
  end

  def check_permissions
    unless current_user.leagues.include?(@league)
      redirect_to root_path, :notice => "You are not part of this league"
    end
  end
end
