FactoryBot.define do
  factory :user, class: User do
    name { Faker::Name.unique.name { 4..10 } }
    sequence(:email) { |n| "#{n}#{Faker::Internet.email}" }
    password { Faker::Internet.password }
  end
end