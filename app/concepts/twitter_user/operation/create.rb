class TwitterUser < ApplicationRecord
  class Create < Trailblazer::Operation
    step :build_user
    step :save_user
    step :start_woker

    def build_user(options, params:, current_user:, **)
      options['model'] = current_user.twitter_users.build(params)
    end

    def save_user(options, **)
      options['model'].save if options['model'].validate
    end

    def start_woker(options, **)
      TwitterWorker.perform_async(options['model'].owner, options['model'].id)
    end
  end
end
