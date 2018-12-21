class TwitterUser < ApplicationRecord
  class Destroy < Trailblazer::Operation
    step Model( TwitterUser, :find_by )
    step :delete_user

    def delete_user(options, params:, **)
    	options[:model].destroy
    end
  end
end
