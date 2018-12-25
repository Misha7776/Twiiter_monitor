class Page < ApplicationRecord
  class Index < Trailblazer::Operation
    step Policy::Guard(->(options, signed_in:, **){ signed_in })
    step :user_ids!
    step :feed!

    def feed!(options, **)
      options[:tweets] = tweets(options[:user_ids_list])
    end

    def tweets(ids_list)
      Tweet.where(twitter_user_id: ids_list).recent_ones
    end

    def user_ids!(options, current_user:, **)
      options[:user_ids_list] = current_user.twitter_users.ids
    end
  end
end