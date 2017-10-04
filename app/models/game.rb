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
end
