FactoryBot.define do
  password = Faker::Internet.password(8, 16, true, true)

  factory :user do
    email Faker::Internet.email
    name Faker::Name.name
    password password
    password_confirmation password
    profile Faker::Hacker.say_something_smart
    works Faker::Company.profession
    avatar Faker::Avatar.image
    occupation Faker::Company.name
  end
end
