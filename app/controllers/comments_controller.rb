class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    result = Comment::Create.(params: params)
    @comment = result[:model]
  end

  def destroy
    result = Comment::Destroy.(params: params)
    @comment = result[:model]
  end
end
