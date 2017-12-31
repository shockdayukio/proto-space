FactoryBot.define do
  factory :prototype do
    name Faker::Beer.name
    catch_copy Faker::Beer.style
    concept Faker::Beer.hop
  end
end
