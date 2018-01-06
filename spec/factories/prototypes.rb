FactoryBot.define do
  DEFAULT_MINIMUM_LIKES_COUNT = 1
  DEFAULT_MAXIMUM_LIKES_COUNT = 300

  factory :prototype, class: Prototype do
    name            { Faker::Beer.name }
    catch_copy      { Faker::Beer.style }
    concept         { Faker::Beer.hop }
    like_count      { Faker::Number.between(DEFAULT_MINIMUM_LIKES_COUNT, DEFAULT_MAXIMUM_LIKES_COUNT) }

    association :user, factory: :user

    trait :with_main_image do
      transient do
        default_main_image_num { Prototype::NUMBER_OF_MAIN_IMAGE_IN_PROTOTYPE }
      end

      after(:build) do |prototype, evaluator|
        prototype.captured_images << build_list(:main_image, evaluator.default_main_image_num)
      end

      after(:create) do |prototype, evaluator|
        prototype.captured_images << create_list(:main_image, evaluator.default_main_image_num)
      end
    end

    trait :with_sub_images do
      transient do
        default_sub_images_num { Prototype::MAXIMUM_NUMBER_OF_SUB_IMAGES_IN_PROTOTYPE }
      end

      after(:build) do |prototype, evaluator|
        prototype.captured_images << build_list(:sub_images, evaluator.default_sub_images_num)
      end

      after(:create) do |prototype, evaluator|
        prototype.captured_images << create_list(:sub_images, evaluator.default_sub_images_num)
      end
    end

    trait :with_comments do
      transient do
        default_comments_num 10
      end

      after(:build) do |prototype, evaluator|
        prototype.comments << build_list(:comment, evaluator.default_comments_num)
      end

      after(:create) do |prototype, evaluator|
        prototype.comments << build_list(:comment, evaluator.default_comments_num)
      end
    end

    trait :with_likes do
      transient do
        default_likes_num 10
      end

      after(:build) do |prototype, evaluator|
        prototype.likes << build_list(:like, evaluator.default_likes_num)
      end

      after(:create) do |prototype, evaluator|
        prototype.likes << create_list(:like, evaluator.default_likes_num)
      end
    end
  end

  factory :new_prototype, class: Prototype do
  end
end
