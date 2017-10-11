class Season < ApplicationRecord
	validates :start,  :presence => true
	validates :end,    :presence => true
	validates :status, :presence => true
  validate  :proper_times

	has_many :games
	belongs_to :league

  def proper_times
    if self.start > self.end
      errors.add(:start, "Your start date most be before your end date")
    end

    if self.start < Time.now
      errors.add(:start, "You can't put a season start date that is in the past")
    end
  end

	def to_param
		season_id
	end

  def has_games
    games.count > 0
  end

  def change_status
    if self.status == "Active"
      self.status = "Inactive"
    elsif self.status == "Inactive" && league.current_season.nil?
      self.status = "Active"
    else
      return false
    end

    self.save
  end

	def player_names
    players = []
    league.players.each do |player|
      players.push(player.name)
    end

    players
  end
end
