class Comment < ApplicationRecord
	class Create < Trailblazer::Operation
		step Model(Comment, :new)
		step Comment::Create::Contract::Build( constant: Comment::Contract::Create )
    step Comment::Create::Contract::Validate( key: :comment )
    step Comment::Create::Contract::Persist()
	end
end