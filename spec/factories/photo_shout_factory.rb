FactoryBot.define do
  factory :photo_shout do
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/dice.png'), 'image/png') }
  end
end
