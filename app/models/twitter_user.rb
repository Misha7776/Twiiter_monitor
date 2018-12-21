class TwitterUser < ApplicationRecord
  before_validation :make_name_correct, if: :name_changed?
  before_save :set_default, on: %i[create update]

  VALID_NAME_REGEX = /[^0-9A-Za-z]/

  belongs_to :user
  has_many :tweets, dependent: :destroy

  validates :owner, presence: true
  validates :name, uniqueness: true, presence: true

  validates :uid, presence: false, allow_nil: true
  validate :monitored, on: :create

  scope :popular_first, -> { order(followers: :desc) }

  def without_avatar
    TwitterUser.where(image_url: nil)
  end

  def make_name_correct
    return unless name
    name.gsub!(VALID_NAME_REGEX, '')
    name.capitalize!
  end

  def set_default
    self.uid ||= 0
  end

  def monitored
    errors.add(:owner, 'already exists in your twitter user list') if
        TwitterUser.exists?(owner: owner)
  end
end
