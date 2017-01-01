class Game < ApplicationRecord
   validates :home_user,           :presence => true
   validates :home_score,          :presence => true
   validates :away_user,           :presence => true
   validates :away_score,          :presence => true
   validates :winner,              :presence => true
end
