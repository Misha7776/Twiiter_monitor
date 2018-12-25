class TwitterWorker
  include Sidekiq::Worker
  NUMBER_OF_TWEETS = 20

  def perform(owner, twitter_user_id, current_user_id)
    twitter_user = find_user(twitter_user_id)
    twitter_data = twitter_resource(owner)
    update_status(twitter_user, 'In progress', current_user_id)
    twitter_user.update_attributes(followers:          twitter_data.followers,
                           following:          twitter_data.following,
                           image_url:          twitter_data.image_url,
                           created_at_twitter: twitter_data.created,
                           description:        twitter_data.description)
    twitter_user_posts(twitter_data.tweets, twitter_user)
    update_status(twitter_user, 'Completed', current_user_id)
  end

  private

  def find_user(user_id)
    TwitterUser.find(user_id)
  end

  def twitter_resource(owner)
    TwitterProcessor.new(owner: owner, number_of_tweets: NUMBER_OF_TWEETS)
  end

  def twitter_user_posts(tweets, twitter_user)
    tweets.each do |tweet|
      twitter_user.tweets.build(full_text: tweet.full_text,
                        created: tweet.created_at,
                        favorite_count: tweet.favorite_count,
                        uri: tweet.uri).save
    end
  end

  def update_status(twitter_user, status, current_user_id)
    ActionCable.server.broadcast "notifications:#{current_user_id}", 
                                  status: "#{status}",
                                  twitter_user: twitter_user
  end
end
