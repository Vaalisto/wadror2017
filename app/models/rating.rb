class Rating < ActiveRecord::Base
	belongs_to :beer

	def to_s
		"tekstiselitys"
	end
end
