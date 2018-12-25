class Comment < ApplicationRecord
  belongs_to :tweet
  after_create_commit { RenderCommentJob.perform_now self }
  after_destroy_commit { DeleteCommentJob.perform_now self }
end
