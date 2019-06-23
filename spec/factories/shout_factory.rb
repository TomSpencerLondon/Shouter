FactoryBot.define do
  factory :shout do
    user { user }

    trait :text_shout do
      after(:build) do |shout|
        shout.content = FactoryBot.create(:text_shout)
      end
    end

    trait :photo_shout do
      after(:build) do |shout|
        shout.content = FactoryBot.create(:photo_shout)
      end
    end

    trait :reindex do
      after(:create) do |product, _evaluator|
        product.reindex(refresh: true)
      end
    end
  end
end
