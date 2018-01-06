FactoryBot.define do

  factory :user, class: User do
    email         {Faker::Internet.email}
    name          {Faker::Name.name}
    password      {Faker::Internet.password(8, 16, true, true)}
    avatar        {fixture_file_upload(Rails.root.join('app/assets/images/shiba.jpg'))}
    profile       {Faker::Hacker.say_something_smart}
    works         {Faker::Company.profession}
    occupation    {Faker::Company.name}

    trait :with_prototypes do
      transient do
        default_prototypes_num 3
      end

      after(:create) do |user, evaluator|
        user.prototypes << create_list(:prototype, evaluator.default_prototypes_num)
      end
    end
  end
end

# FactoryBot 参考
# http://ruby-rails.hatenadiary.com/entry/20150102/1420174315

# FactoryBot Dynamic Attributes
# https://github.com/thoughtbot/factory_bot/blob/master/GETTING_STARTED.md
