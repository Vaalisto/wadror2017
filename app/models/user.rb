class User < ActiveRecord::Base
	include RatingAverage

	has_many :ratings, dependent: :destroy
	has_many :beers, through: :ratings

	has_secure_password

	validates :username, uniqueness: true,
						length: { in: 3..30 }
	validates :password, format: { with: /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{4,}\z/ } 	

end
