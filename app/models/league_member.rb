class LeagueMember < ApplicationRecord
	belongs_to :league
	belongs_to :user
end
