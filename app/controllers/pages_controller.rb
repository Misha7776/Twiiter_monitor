class PagesController < ApplicationController
  def index
    result = Page::Index.(params: params, current_user: current_user, signed_in: user_signed_in?)
    @tweets_feed = result[:tweets]
  end
end
