class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_NAME_REGEX = /[a-zA-Z0-9]/
  before_save :capitalize_name, on: %i[create update]
  after_create :send_email

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :twitter_users, dependent: :destroy

  validates :name, presence: true, format: { with: VALID_NAME_REGEX,
                                             message: 'only allows letters and digits' },
                   uniqueness: true
  validates :email, presence: true, uniqueness: true,
                    format: { with: VALID_EMAIL_REGEX,
                              message: 'invalid email' }

  validates :encrypted_password, presence: true,
                                 length: { minimum: 6 },
                                 allow_blank: false

  scope :desc, -> { order(created_at: :desc) }
  scope :asc,  -> { order(created_at: :asc) }
  scope :alphabetic, -> { order(name: :asc) }

  def capitalize_name
    name.capitalize!
  end

  def send_email
    UserMailer.registration(self).deliver
  end
end
