class League < ApplicationRecord
	has_many :seasons, :dependent => :destroy

	has_many :league_members
	has_many :players, :through => :league_members, :source => :user

	validates :name,         :presence => true
	validates :display_name, :presence => true
	validates :password,     :presence => true
	validates :sport,        :presence => true

	def commissioner 
		league_members.where(:role => "commissioner").first.try(:user) 
	end
end
