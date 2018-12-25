class TwitterUser < ApplicationRecord
  class Create < Trailblazer::Operation
    step Model(TwitterUser, :new)
    step :assign_user
    step TwitterUser::Create::Contract::Build( constant: TwitterUser::Contract::Create )
    step TwitterUser::Create::Contract::Validate( key: :twitter_user )
    step TwitterUser::Create::Contract::Persist( )
    step :start_woker

    def assign_user(options, params:, current_user:, **)
      options[:model].user = current_user
    end

    def start_woker(options, model:, current_user:, **)
      job_id = TwitterWorker.perform_async(model.owner, model.id, current_user.id)
      options[:model].update(job_id: job_id)
    end
  end
end
