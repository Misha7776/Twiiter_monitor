module Comment::Contract
	class Create < Reform::Form
		property :body
		property :tweet_id

		validates :body, presence: true
		validates :tweet_id, presence: true
	end
end