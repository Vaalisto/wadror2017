class Rating < ActiveRecord::Base
	belongs_to :beer
	belongs_to :user

	scope :recent, -> { order(created_at: :desc).limit(5) }

	validates :score, numericality: { greater_than_or_equal_to: 1,
									  less_than_or_equal_to: 50,
									  only_integer: true}

	def top_breweries
		return nil if ratings.empty?

		averages = []
		ratings.beer.brewery.each do |brewery, average|
			average << {
				brewery: brewery,
				average: brewery.average_rating
			}		
		end
		averages.sort_by{ |b| -b[:average]}.limit(3)
	end

	def to_s
		"#{beer.name} #{score}"
	end
end
