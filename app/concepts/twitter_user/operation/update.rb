class TwitterUser < ApplicationRecord
  class Update < Trailblazer::Operation
    step Nested( Edit )
    step :update_user

    def update_user(options, params:, **)
      options[:model].update_attributes(params)
    end
  end
end
