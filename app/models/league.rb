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

	def self.SPORTS
		%w[FIFA 2K Madden]
	end

	def to_param
		name
	end
end
