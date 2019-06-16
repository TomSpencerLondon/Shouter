FactoryBot.define do
  factory :user do
    email {'tim@tim.com'}
    username {'Tim'}
    password_digest {'password'}
  end
end
