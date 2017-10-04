class Season < ApplicationRecord
	validates :start,  :presence => true
	validates :end,    :presence => true
	validates :status, :presence => true

	has_many :games
	belongs_to :league

	def to_param
		season_id
	end

	def player_names
    players = []
    league.players.each do |player|
      players.push(player.name)
    end

    players
  end
end
