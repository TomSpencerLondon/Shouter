# frozen_string_literal: true

require 'rails_helper'

describe Autocomplete do
  let(:user) do
    FactoryBot.create(:user,
                      email: "lewis@lewis.com",
                      password_digest: "Testing123",
                      username: "lewis")
  end

  let(:text_shout) do
    FactoryBot.create(:text_shout,
                      id: 1,
                      body: "#hello. This is a text shout")
  end

  let(:text_shout_two) do
    FactoryBot.create(:text_shout,
                      id: 2,
                      body: "#wow. This is another text_shout")
  end

  let(:text_shout_three) do
    FactoryBot.create(:text_shout,
                      id: 3,
                      body: "Dice!")
  end

  let(:photo_shout) do
    FactoryBot.create(:photo_shout)
  end

  let(:subject) do
    described_class.new(term: term)
  end

  before do
    [text_shout, text_shout_two, text_shout_three, photo_shout].map do |shout|
      FactoryBot.create(:shout, :reindex, user: user, content: shout)
    end
  end

  context 'when the search term is entered' do
    let(:term) { "hello" }

    context '#matches' do
      it 'returns the correct text_shout' do
        expect(subject.matches).to include(text_shout.body)
      end

      it 'does not return other shouts' do
        expect(subject.matches).not_to include(text_shout_two.body)
        expect(subject.matches).not_to include(text_shout_three.body)
        expect(subject.matches).not_to include(photo_shout.image_file_name)
      end
    end
  end

  context 'when the search term is name of photo_shout and text_shout' do
    let(:term) { "dice" }

    context '#matches' do
      it 'returns the correct text_shout and the photo_shout with same file name' do
        expect(subject.matches).to include(text_shout_three.body)
        expect(subject.matches).to include(photo_shout.image_file_name)
      end
    end
  end
end
