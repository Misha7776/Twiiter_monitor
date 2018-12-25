class TwitterUser < ApplicationRecord
  class Update < Trailblazer::Operation
    step Nested( Edit )
    step TwitterUser::Create::Contract::Build(constant: TwitterUser::Contract::Create)
    step TwitterUser::Create::Contract::Validate( key: :twitter_user )
    step TwitterUser::Create::Contract::Persist( )
  end
end
