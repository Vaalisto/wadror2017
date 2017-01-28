class Brewery < ActiveRecord::Base
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end

	def average_rating
		return ratings.average(:score)
	end

	def restart
		self.year = 2017
		puts "changed year to #{year}"
	end
end
