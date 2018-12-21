class TwitterUser < ApplicationRecord
  class Show < Trailblazer::Operation
    step Model( TwitterUser, :find_by )
    step :tweets

    def tweets(options, **)
      options[:tweets] = options[:model].tweets
    end
  end
end
