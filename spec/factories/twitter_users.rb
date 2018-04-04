FactoryBot.define do
  factory :twitter_user, class: TwitterUser do
    name  { Faker::Name.unique.name { 4..10 } }
    owner { Faker::Name.unique.name { 4..10 } }
    user  { build(:user) }
    # followers { rand(10..100) }
    # following { rand(10..100) }
  end
end