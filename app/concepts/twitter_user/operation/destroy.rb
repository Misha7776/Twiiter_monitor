class TwitterUser < ApplicationRecord
  class Destroy < Trailblazer::Operation
    step Model( TwitterUser, :find_by )
    step :delete!

    def delete!(options, model:, **)
    	model.destroy
    end
  end
end
