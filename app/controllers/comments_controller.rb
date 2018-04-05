class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = tweet_resource.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js
      else
        format.js { render(js: "alert('Comment is invalid!');") }
      end
    end
  end

  def destroy
    @comment = comment_resource
    respond_to do |format|
      if @comment.destroy
        format.html { redirect_back fallback_location: root_path }
        format.js
      else
        format.js { render(js: "alert('No rights to delete this comment');") }
      end
    end
  end

  private

  def comment_resource
    Comment.find(params[:id])
  end

  def tweet_resource
    Tweet.find(params[:comment][:tweet_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :tweet_id)
  end
end
