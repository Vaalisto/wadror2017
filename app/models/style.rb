class Style < ActiveRecord::Base
	has_many :beer

	def to_s
		"#{name}"
	end

end
