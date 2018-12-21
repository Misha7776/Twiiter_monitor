class TwitterUser < ApplicationRecord
  class Edit < Trailblazer::Operation
    step Model( TwitterUser, :find_by )
  end
end
