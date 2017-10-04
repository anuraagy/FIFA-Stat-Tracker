module ApplicationHelper
	def curr_league		
		if params[:name]
			league = League.find_by(:name => params[:name])
		elsif params[:league_name]
			league = League.find_by(:name => params[:league_name])
		end

		league
	end

	def curr_season		
		if params[:season_id]
			season = Season.find_by(:season_id => params[:season_id])
		elsif params[:league_name]
			season = Season.find_by(:season_id => params[:season_season_id])
		end

		season
	end
end
