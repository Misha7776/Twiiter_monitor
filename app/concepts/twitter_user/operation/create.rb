class TwitterUser < ApplicationRecord
  class Create < Trailblazer::Operation
    binding.pry
    extend Contract::DSL

    contract do
      property :name
      property :owner

      # validates :name, uniqueness: true, presence: true
      validates :owner, presence: true
    end

    step :build_user
    # step Contract::Build(constant: TwitterUser::Contract::Create)
    # step Contract::Validate(key: 'twitter_user')
    # step Contract::Persist()
    step :start_woker

    def build_user(options, params:, current_user:, **)
      options['model'] = current_user.twitter_users.build(params)
    end

    def start_woker(options, **)
      TwitterWorker.perform_async(options['model'].owner, options['model'].id)
    end
  end
end
