FactoryBot.define do
  factory :like do
    association :user, factory: :user
    association :prototype, factory: :prototype
  end
end
