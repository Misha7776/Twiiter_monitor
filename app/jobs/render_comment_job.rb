class RenderCommentJob < ApplicationJob
  queue_as :default

  def perform(comment)
    ActionCable.server.broadcast "tweet_comments", 
							    							  html: render_comment(comment),
							    							  comment: comment,
							    							  action: 'create'
  end

  private

	def render_comment(comment)
	  ApplicationController.renderer.render(partial: 'comments/comment', locals: { comment: comment })
	end
end