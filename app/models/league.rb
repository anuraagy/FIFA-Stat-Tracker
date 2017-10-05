	class League < ApplicationRecord
	has_many :seasons, -> { order(created_at: :asc) } , :dependent => :destroy
	has_many :league_members
	has_many :players, :through => :league_members, :source => :user

	validates :name,         :presence => true
	validates :display_name, :presence => true
	validates :password,     :presence => true
	validates :sport,        :presence => true

	def current_season
		seasons.where(:status => "Active").first
	end

	def commissioner 
		league_members.where(:role => "commissioner").first.try(:user) 
	end

	def has_commissioner?(user)
		user == commissioner
	end

	def has_player(user)
		players.include?(user)
	end

	def add_commissioner(user) 
		league_member = LeagueMember.new(:league_id => id, :user_id => user.id, :role => "commissioner")
    league_member.save
	end

	def add_player(user)
		if has_player(user)
      return "You are already part of this league"
    else
      league_member = LeagueMember.new(:league_id => id, :user_id => user.id, :role => "player")
      
      if league_member.save
        return "You have successfully join this league"
      else
        return "An error occured, please try again later"
      end
    end
	end

	def self.SPORTS
		%w[FIFA 2K Madden]
	end

	def to_param
		name
	end
end
