class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_tweet, only: %i[create]

  def create
    @comment = @tweet.comments.build(comment_params)
    respond_to do |format|
    if @comment.save
      format.html { redirect_to twitter_user_path(@tweet.twitter_user_id) }
      format.js
    else
      render :new
    end
    end
  end

  def destroy
    binding.pry
    @comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comments deleted'
    redirect_to twitter_user_path(@tweet.twitter_user_id)
  end

  private

  def find_tweet
    @tweet = Tweet.find(params[:comment][:tweet_id])
  end

  def comment_params
    params.require(:comment).permit(:body, :tweet_id)
  end
end
