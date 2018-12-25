module TwitterUser::Contract
  class Create < Reform::Form
    property :name
    property :owner

    validates_uniqueness_of :name

    validates :name, presence: true
    validates :owner, presence: true
  end
end
