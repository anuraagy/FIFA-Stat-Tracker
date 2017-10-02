class LeaguesController < ApplicationController

  before_action :check_permissions, :only => [:show, :edit, :update, :destroy]
  before_action :check_join, :only => [:join]
  before_action :check_commissioner, :only => [:edit, :update, :destroy]

  def index
    @leagues = League.all
  end

  def myleagues
    @leagues = current_user.leagues
  end

  def join
    @league = League.find_by!(:name => params[:name])    
  end

  def add_player
    @league = League.find_by!(:name => params[:name])

    if params[:password] != @league.password
      redirect_to join_league_path(@league.name), :notice => "The password you entered is incorrect, please try again"
    elsif current_user.leagues.include?(@league)
      redirect_to league_path(@league.name), :notice => "You are already part of this league"
    else
      @league_member = LeagueMember.new(:league_id => @league.id, :user_id => current_user.id, :role => "player")
      if @league_member.save
        redirect_to league_path(@league.name), :notice => "You have successfully join this league"
      else
        redirect_to league_path(@league.name), :notice => "An error occured, please try again later"
      end
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

    if @league.save && add_commissioner
      redirect_to league_path(@league.name)
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
      redirect_to league_path(@league.name), :notice => "You have successfully updated the league"
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
    params[:league][:name] = SecureRandom.urlsafe_base64(8) unless params[:league][:name]
    params.require(:league).permit(:name, :display_name, :password, :sport)
  end

  def add_commissioner
    @league_member = LeagueMember.new(:league_id => @league.id, :user_id => current_user.id, :role => "commissioner")
    
    @league_member.save
  end

  def check_commissioner
    @league = League.find_by!(:name => params[:name])

    unless LeagueMember.where(:user_id => current_user.id, :league_id => @league.id).first.role == "commissioner"
      redirect_to league_path(@league), :notice => "You are not a commissioner of this league"
    end
  end

  def check_permissions
    @league = League.find_by!(:name => params[:name])

    unless current_user.leagues.include?(@league)
      redirect_to root_path, :notice => "You are not part of this league"
    end
  end

  def check_join
    @league = League.find_by!(:name => params[:name])    

    if current_user.leagues.include?(@league)
      redirect_to league_path(@league.name), :notice => "You are already part of this league"
    end
  end

end
