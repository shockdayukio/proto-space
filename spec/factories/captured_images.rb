include ActionDispatch::TestProcess

FactoryBot.define do
  factory :captured_image, class: CapturedImage do
    image {fixture_file_upload(Rails.root.join('app/assets/images/shiba.jpg'))}
    association :prototype, factory: :prototype, name: Faker::Beer.name

    trait :main do
      status :main
    end

    trait :sub do
      status :sub
    end

    factory :main_image, traits: [:main]
    factory :sub_images, traits: [:sub]
  end
end
