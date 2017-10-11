module ApplicationHelper
	def curr_league		
		if params[:name]
			@league = League.find_by(:name => params[:name])
		elsif params[:league_name]
			@league = League.find_by(:name => params[:league_name])
		end

		@league
	end
end
