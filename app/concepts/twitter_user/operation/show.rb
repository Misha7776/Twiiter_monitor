class TwitterUser < ApplicationRecord
  class Show < Trailblazer::Operation
    step :collection
    step :resource
    step :tweets

    def collection(options, current_user:, **)
      options['collection'] = current_user.twitter_users.all
    end

    def resource(options, params:, **)
      options['user'] = options['collection'].find(params[:id])
    end

    def tweets(options, **)
      options['tweets'] = options['user'].tweets
    end
  end
end
