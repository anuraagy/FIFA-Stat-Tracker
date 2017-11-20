module SeasonsHelper

  def gfpg(player)
    stats = player.stats(@season)

    if stats[:games] != 0
      number_with_precision((stats[:goals_for] + 0.0)/(stats[:games]), :precision => 2)
    else 
      "0"
    end 
  end

  def gapg(player)
    stats = player.stats(@season)

    if stats[:games] != 0
      number_with_precision((stats[:goals_against] + 0.0)/(stats[:games]), :precision => 2)
    else 
      "0"
    end  
  end

  def ppg(player)
    stats = player.stats(@season)

    if stats[:games] != 0
      number_with_precision((stats[:points] + 0.0)/(stats[:games]), :precision => 2)
    else 
      "0"
    end  
  end

  def wp(player)
    stats = player.stats(@season)

    if stats[:games] != 0
      number_with_precision((stats[:games_won] + 0.0)/(stats[:games]), :precision => 3)
    else 
      ".000"
    end
  end
end
