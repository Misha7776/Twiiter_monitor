class TwitterUser < ApplicationRecord
  class Index < Trailblazer::Operation
    step :collection!
    success :popular_first!

    def collection!(options, current_user:, **)
      options['collection'] = current_user.twitter_users.all
    end

    def popular_first!(options, **)
      options['model'] = options['collection'].popular_first
    end
  end
end
