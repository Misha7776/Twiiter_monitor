class Comment < ApplicationRecord
	class Destroy < Trailblazer::Operation
		step Model(Comment, :find_by)
		step :delete!

		def delete!(options, model:, **)
			model.destroy
		end
	end
end