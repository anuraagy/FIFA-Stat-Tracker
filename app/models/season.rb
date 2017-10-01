class Season < ApplicationRecord
	validates :start,  :presence => true
	validates :end,    :presence => true
	validates :status, :presence => true

	belongs_to :league
end
