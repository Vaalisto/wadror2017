module RatingAverage
	extend ActiveSupport::Concern
	def average_rating
		average = ratings.average(:score)
		if average.nil?
			0
		else
			average
		end
	end
end