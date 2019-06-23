require 'rails_helper'

describe PhotoShout do
  include LoginHelpers
  include ShoutHelpers

  let!(:subject) do
    described_class
  end

  context 'with image' do
    let!(:file) do
      Rails.root.join('spec/fixtures/dice.png')
    end

    let!(:image) do
      Rack::Test::UploadedFile.new(file, 'image/png')
    end

    it 'is valid' do
      photo_shout = subject.create(image: image)
      expect(photo_shout.valid?).to eq(true)
    end
  end

  context 'without image' do
    it 'is invalid' do
      photo_shout = subject.create(image: nil)
      expect(photo_shout.valid?).to eq(false)
    end
  end
end
