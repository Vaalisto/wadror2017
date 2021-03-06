class Brewery < ActiveRecord::Base
	include RatingAverage
	extend Top
	
	has_many :beers, dependent: :destroy
	has_many :ratings, through: :beers

	scope :active, -> { where active:true }
  	scope :retired, -> { where active:[nil,false] }  	

	validates :name, presence: true
	validates :year, numericality: { :greater_than_or_equal_to => 1042, 
                                     :less_than_or_equal_to => lambda {|_| Time.now.year},
	                                 :only_integer => true }

	def print_report
		puts name
		puts "established at year #{year}"
		puts "number of beers #{beers.count}"
	end

	def restart
		self.year = 2017
		puts "changed year to #{year}"
	end

	def to_s
		"#{name}"
	end
end
