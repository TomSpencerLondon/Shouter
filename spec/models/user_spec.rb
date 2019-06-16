
require 'rails_helper'

describe User do
  let(:email) { "lewis@lewis.com" }
  let(:password_digest) { "Testing123" }
  let(:username) { "lewis" }
  let(:user) do
    described_class.create(email: email,
                           password_digest: password_digest,
                           username: username)
  end

  let(:user_two) do
    FactoryBot.create(:user,
                      email: 'harry@harry.com',
                      username: 'Harry',
                      password_digest: 'Testing123')
  end

  context 'invalid user' do
    context 'email not unique' do
      let(:user_three) do
        described_class.create(email: 'lewis@lewis.com',
                               username: 'Harry',
                               password_digest: 'Testing123')
      end

      it '#invalid? is true' do
        user
        expect(user_three.valid?).to eq(false)
      end

      it '#errors' do
        user
        expect(user_three.errors.count).to eq(1)
        expect(user_three.errors[:email]).to eq(["has already been taken"])
      end
    end

    context 'username not present' do
      let(:user_three) do
        described_class.create(email: 'david@david.com',
                               username: '',
                               password_digest: 'Testing123')
      end

      it '#invalid? is true' do
        user
        expect(user_three.valid?).to eq(false)
      end

      it '#errors' do
        user
        expect(user_three.errors.count).to eq(1)
        expect(user_three.errors[:username]).to eq(["can't be blank"])
      end
    end

    context 'password not present' do
      let(:user_three) do
        described_class.create(email: 'david@david.com',
                               username: 'David',
                               password_digest: '')
      end

      it '#invalid? is true' do
        user
        expect(user_three.valid?).to eq(false)
      end

      it '#errors' do
        user
        expect(user_three.errors.count).to eq(1)
        expect(user_three.errors[:password_digest]).to eq(["can't be blank"])
      end
    end
  end

  context 'valid user without shouts, followed or following' do
    it 'is valid' do
      expect(user.valid?).to eq(true)
      expect(user.errors.count).to eq(0) 
    end

    it 'creates a user instance' do
      expect(user.instance_of?(User)).to eq(true)
    end

    it 'user is not following user_two' do
      expect(user.following?(user_two)).to eq(false)
    end

    it 'has no shouts' do
      expect(user.shouts.all.count).to eq(0)
    end
  end

  context 'valid user with shouts' do
    it 'creates a user instance' do
      expect(user.instance_of?(User)).to eq(true)
    end

    it 'has shouts' do
      create_user_shouts
      expect(user.shouts.all.count).to eq(2)
    end
  end

  context 'user following another user' do
    it 'user can follow user_two' do
      user.follow(user_two)
      expect(user.following?(user_two)).to eq(true)
    end

    it 'user can unfollow user_two' do
      user.follow(user_two)
      expect(user.following?(user_two)).to eq(true)
      user.unfollow(user_two)
      expect(user.following?(user_two)).to eq(false)
    end
  end
end

def create_user_shouts
  FactoryBot.create(:shout, :text_shout, user: user)
  FactoryBot.create(:shout, :photo_shout, user: user)
end
