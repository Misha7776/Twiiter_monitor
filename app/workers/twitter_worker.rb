class TwitterWorker
  include Sidekiq::Worker
  NUMBER_OF_TWEETS = 20

  def perform(owner, twitter_user_id)
    user = find_user(twitter_user_id)
    twitter_data = twitter_resource(owner)
    user.update_attributes(followers:          twitter_data.followers,
                           following:          twitter_data.following,
                           image_url:          twitter_data.image_url,
                           created_at_twitter: twitter_data.created,
                           description:        twitter_data.description)
    twitter_user_posts(twitter_data.tweets, user)
  end

  private

  def find_user(user_id)
    TwitterUser.find(user_id)
  end

  def twitter_resource(owner)
    TwitterProcessor.new(owner: owner, number_of_tweets: NUMBER_OF_TWEETS)
  end

  def twitter_user_posts(tweets, user)
    tweets.each do |tweet|
      user.tweets.build(full_text: tweet.full_text,
                        created: tweet.created_at,
                        favorite_count: tweet.favorite_count,
                        uri: tweet.uri).save
    end
  end
end
