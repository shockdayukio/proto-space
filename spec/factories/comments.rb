FactoryBot.define do
  factory :comment do
    text { Faker::Hacker.say_something_smart }

    association :user, factory: :user
    association :prototype, factory: :prototype
  end
end
