module TwitterUser::Contract
  class Create < Reform::Form
    model :twitter_user

    property :name
    property :owner

    validates :name, presence: true
    validates :owner, presence: true
  end
end
