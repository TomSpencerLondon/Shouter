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
  end
end
