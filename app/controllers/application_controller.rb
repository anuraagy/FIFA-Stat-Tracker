class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def check_commissioner
    @league = League.find_by!(:name => params[:name])
    
    unless @league.has_commissioner?(current_user)
      redirect_to league_path(@league), :notice => "You are not a commissioner of this league" 
    end
  end
  
  def check_permissions
    @league = League.find_by!(:name => params[:name])

    unless current_user.is_part_of?(@league)      
      redirect_to root_path, :notice => "You are not part of this league"
    end
  end
end
