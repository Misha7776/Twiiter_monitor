class DeleteCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "tweet_comments", comment: comment
  end
end