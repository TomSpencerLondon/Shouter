require 'rails_helper'

describe Timeline do
  let(:user) do
    FactoryBot.create(:user)
  end

  let(:timeline) do
    described_class.new(user)
  end

  let(:user_two) do
    FactoryBot.create(:user,
                      email: 'harry@harry.com',
                      username: 'Harry',
                      password_digest: 'Testing123')
  end

  context 'when user is not following anyone' do
    it 'shows shouts for current_user' do
      create_user_shouts
      expect(timeline.shouts.count).to eq(2)
    end
  end

  context 'when user is following another user with a text_shout' do
    it 'shows shouts for current_user and followed user' do
      create_user_shouts
      FactoryBot.create(:shout, :text_shout, user: user_two)

      user.follow(user_two)
      expect(timeline.shouts.count).to eq(3)
    end
  end
end

def create_user_shouts
  FactoryBot.create(:shout, :text_shout, user: user)
  FactoryBot.create(:shout, :photo_shout, user: user)
end
