class PagesController < ApplicationController

  def index
    @tweets_feed = feed
  end

  private

  def feed
    Tweet.where('twitter_user_id IN (:ids)', ids: user_ids_list).recent_ones
  end

  def user_ids_list
    current_user.twitter_users.ids if user_signed_in?
  end
end
