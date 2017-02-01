module RatingAverage
	extend ActiveSupport::Concern
	def average_rating
		ratings.map{ |r| r.score}.sum / ratings.count.to_f
	end
end