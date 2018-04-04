class TwitterProcessor
  def initialize(user:, number_of_tweets:)
    @twitter_owner = user
    @count = number_of_tweets
    @client = initialize_twitter_client
    @user_id = user_id
    @description = description
    @followers = followers
    @following = following
    @tweets = tweets
    @created = created
    @image_url = image_url
  end

  def screen_name
    @screen_name ||= @twitter_owner.sub('https://twitter.com/', '') if @twitter_owner.present?
  end

  def tweets
    @tweets ||= begin
      screen_name.blank? ? [] : scrape_tweets
    end
  end

  def followers
    @followers ||= begin
      scrape_followers if screen_name.present?
    end
  end

  def created
    @created_at ||= begin
      scrape_create_at if screen_name.present?
    end
  end

  def image_url
    @prof_image ||= begin
      scrape_profile_image if screen_name.present?
    end
  end

  def following
    @following ||= begin
      scrape_following if screen_name.present?
    end
  end

  def description
    @description ||= begin
      scrape_description if screen_name.present?
    end
  end

  def user_id
    @user_id ||= begin
      scrape_id if screen_name.present?
    end
  end

  private

  def initialize_twitter_client
    Twitter::REST::Client.new do |config|
      secrets = Rails.application.secrets
      config.consumer_key        = secrets.twitter_consumer_key
      config.consumer_secret     = secrets.twitter_consumer_secret
    end
  end

  def scrape_tweets
    @client.user_timeline(screen_name, count: @count)
  rescue Twitter::Error
    []
  end

  def scrape_followers
    @client.user(screen_name).followers_count
  rescue Twitter::Error
    nil
  end

  def scrape_create_at
    @client.user(screen_name).created_at
  rescue Twitter::Error
    nil
  end

  def scrape_profile_image
    @client.user(screen_name).profile_image_url.to_s.remove('_normal')
  rescue Twitter::Error
    nil
  end

  def scrape_following
    @client.user(screen_name).friends_count
  rescue Twitter::Error
    nil
  end

  def scrape_description
    @client.user(screen_name).description
  rescue Twitter::Error
    nil
  end

  def scrape_id
    @client.user(screen_name).id
  rescue Twitter::Error
    nil
  end

  def scrape_user
    @client.user(screen_name)
  rescue Twitter::Error
    nil
  end
end
