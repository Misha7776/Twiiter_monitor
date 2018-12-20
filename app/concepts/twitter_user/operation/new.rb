class TwitterUser < ApplicationRecord
  class New < Trailblazer::Operation
    success :build_user

    def build_user(options, current_user:, **)
      options['model'] = current_user.twitter_users.build
    end
  end
end
