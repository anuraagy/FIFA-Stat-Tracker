class LeaguesController < ApplicationController
  def index
    @leagues = League.all
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

  def edit
    @league = League.find(params[:id])
  end

  def update
    @league = League.find(params[:id])

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
end
