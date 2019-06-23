# frozen_string_literal: true

require 'rails_helper'

describe Shout do
  let(:email) { "lewis@lewis.com" }
  let(:password_digest) { "Testing123" }
  let(:username) { "lewis" }

  let!(:user) do
    FactoryBot.create(:user,
                      email: email,
                      password_digest: password_digest,
                      username: username)
  end

  let!(:text_shout) do
    FactoryBot.create(:text_shout,
                      id: 1,
                      body: "Hello! This is a text shout")
  end

  let!(:photo_shout) do
    FactoryBot.create(:photo_shout)
  end

  let!(:subject) do
    described_class
  end

  context 'model associations' do
    
    let!(:subject) do
      described_class.create(user: user,
                             content: text_shout)
    end

    it { should belong_to :user }
    it { should belong_to :content }
  end

  context '#self.text_shout' do
    let!(:text_shout_two) do
      FactoryBot.create(:text_shout,
                        id: 2,
                        body: "Wow! This is another text_shout")
    end

    let!(:text_shout_three) do
      FactoryBot.create(:text_shout,
                        id: 3,
                        body: "And again! Here is another text_shout")
    end

    before do
      [text_shout, text_shout_two, text_shout_three].map do |text_shout|
        subject.create(user: user, content: text_shout)
      end
    end

    it '#text_shouts returns all the text_shouts' do
      expect(subject.text_shouts.count).to eq(3)
    end
  end

  context 'Shout without user' do
    let(:shout) do
      subject.create(content: text_shout)
    end

    it 'is not valid' do
      expect(shout.valid?).to eq(false)
    end

    it 'user must exist error' do
      expect(shout.errors.messages[:user]).to eq(["must exist"])
    end
  end

  context 'Shout without content' do
    let(:shout) do
      subject.create(user: user)
    end

    it 'is not valid' do
      expect(shout.valid?).to eq(false)
    end

    it 'content must exist error' do
      expect(shout.errors.messages[:content]).to eq(["must exist"])
    end
  end

  context 'Shout with user and text_shout' do
    let!(:shout) do
      subject.create(user: user, content: text_shout)
    end

    it 'creates a valid Shout' do
      expect(shout.valid?).to eq(true)
    end

    it 'content_type is TextShout' do
      expect(shout.content_type).to eq("TextShout")
    end

    it 'content body is correct' do
      expect(shout.content.body).to eq(text_shout.body)
    end

    it 'content class is TextShout' do
      expect(shout.content.class).to eq(TextShout)
    end

    it 'has correct username' do
      expect(shout.user.username).to eq(user.username)
    end

    it 'correct number of shouts and text_shouts' do
      expect(Shout.all.count).to eq(1)
      expect(TextShout.all.count).to eq(1)
    end
  end

  context 'Shout with user and photo_shout' do
    let!(:shout) do
      subject.create(user: user, content: photo_shout)
    end

    it 'creates a valid Shout' do
      expect(shout.valid?).to eq(true)
    end

    it 'content_type is PhotoShout' do
      expect(shout.content_type).to eq("PhotoShout")
    end

    it 'content class is PhotoShout' do
      expect(shout.content.class).to eq(PhotoShout)
    end

    it 'has correct user' do
      expect(shout.user.username).to eq(user.username)
    end

    it 'has correct number of Shouts and PhotoShouts' do
      expect(Shout.all.count).to eq(1)
      expect(PhotoShout.all.count).to eq(1)
    end
  end
end
