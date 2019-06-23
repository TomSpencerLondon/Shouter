# frozen_string_literal: true

require 'rails_helper'

describe FollowingRelationship do
  let(:email) { "lewis@lewis.com" }
  let(:password_digest) { "Testing123" }
  let(:username) { "lewis" }

  let!(:user) do
    FactoryBot.create(:user,
                      email: email,
                      password_digest: password_digest,
                      username: username)
  end

  let!(:user_two) do
    FactoryBot.create(:user,
                      email: "harry@harry.com",
                      password_digest: "Password123",
                      username: "harry")
  end

  let!(:user_three) do
    FactoryBot.create(:user,
                      email: "will@will.com",
                      password_digest: "Cryptical4321",
                      username: "will")
  end

  let!(:subject) do
    described_class
  end

  context 'model associations' do
    
    let!(:subject) do
      described_class.create(follower: user,
                             followed_user: user_two)
    end

    it { should belong_to :follower }
    it { should belong_to :followed_user }

    it 'user now responds to #following?' do
      expect(user.following?(user_two)).to eq(true)
    end

    it '#unfollow works' do
      expect(user.following?(user_two)).to eq(true)
      user.unfollow(user_two)
      expect(user.following?(user_two)).to eq(false)
    end

    it '#follow another user works' do
      expect(user.following?(user_three)).to eq(false)
      user.follow(user_three)
      expect(user.following?(user_three)).to eq(true)
    end
  end
end

