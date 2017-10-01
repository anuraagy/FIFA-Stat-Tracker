class SeasonsController < ApplicationController
	def index
		@seasons = Season.all
	end

	def new
		@season = Season.new
	end

	def create
		@season = Season.new(season_params)

		if @season.save
			redirect_to @season
		else
			render :new
		end
	end

	def edit
		@season = Season.find(params[:id])
	end

	def update
		@season = Season.find(params[:id])

		if @season.update(season_params)
			redirect_to @season
		else
			render :edit
		end
	end

	def destroy
		@season.destroy

		redirect_to :index
	end

	private

	def season_params
		params.require(:season).permit(:start, :end, :status)
	end
end
