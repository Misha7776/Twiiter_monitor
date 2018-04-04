class Tweet < ApplicationRecord
  belongs_to :twitter_user
  has_many :comments
  # validates_presence_of %i[full_text created]
  # validates_each %i[retweet_count favorite_count], allow_nil: true

  scope :recent_ones, -> {order(created: :desc)}
end
