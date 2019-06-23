# frozen_string_literal: true

require 'rails_helper'

describe Search do
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
                      body: "#again. Here is another text_shout")
  end

  let(:subject) do
    described_class.new(term: term)
  end

  before do
    [text_shout, text_shout_two, text_shout_three].map do |text_shout|
      FactoryBot.create(:shout, :reindex, user: user, content: text_shout)
    end
  end

  context 'when the search term is entered' do
    let(:term) { "#wow" }

    context '#shouts' do
      it 'returns the correct text_shout' do
        expect(subject.shouts.first.content.body).to eq(text_shout_two.body)
      end
    end
  end

  context 'when the search term is not entered' do
    let(:term) { "" }

    context '#shouts' do
      it 'returns all shouts (as default)' do
        expect(subject.shouts.size).to eq(3)
      end
    end
  end
end