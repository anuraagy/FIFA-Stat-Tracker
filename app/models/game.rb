class Game < ApplicationRecord
  validates :home_user,           :presence => true
  validates :home_score,          :presence => true
  validates :away_user,           :presence => true
  validates :away_score,          :presence => true
  validates :winner,              :presence => true
  validate  :validate_players

  belongs_to :season
   
  def to_param
    game_id
  end

  def validate_players
    if home_user == away_user
      errors.add(:base, "Both the home and away user can't be the same! Please make sure that each player is a unique user.")
    end
  end

  def self.approve(game, user)
    if game.reviewer != user.name
      return false
    end
    
    game.reviewed = true
    game.approved = true
    game.save
  end

  def self.decline(game, user)
    if game.reviewer != user.name
      return false
    end
    
    game.reviewed = true
    game.approved = false
    game.save
  end

  def set_reviewer(creator)
    submitter = creator.name
    
    if creator.name == home_user
      self.reviewer = away_user
    elsif creator.name == away_user
      self.reviewer = home_user
    end

    if creator.name != home_user && creator.name != away_user
      errors.add(:base, "You can't submit games for others! Please make sure that one of the players is you.")
    end
  end
end
