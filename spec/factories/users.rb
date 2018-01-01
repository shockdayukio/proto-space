FactoryBot.define do
  password = Faker::Internet.password(8, 16, true, true)

  factory :user do
    email Faker::Internet.email
    name Faker::Name.name
    avatar {fixture_file_upload(Rails.root.join('app/assets/images/shiba.jpg'))}
    password password
    profile Faker::Hacker.say_something_smart
    works Faker::Company.profession
    occupation Faker::Company.name

    after(:create) do |user|
      create_list(:prototype, 3, user: user)
    end
  end
end
