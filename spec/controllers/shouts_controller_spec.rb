# frozen_string_literal: true

require 'rails_helper'

describe ShoutsController, type: :request do
  include LoginHelpers

  let(:user) do
    FactoryBot.create(:user,
                      email: 'harry@harry.com',
                      username: 'Harry',
                      password_digest: 'Testing123')
  end

  describe 'show' do
    it 'returns shout' do
      create_user_shouts
      get '/shouts/1'
      expect(response.status).to eq(200)
      expect(@controller.instance_variable_get(:@shout).content_type).to eq("TextShout")
    end
  end

  describe 'destroy' do
    it 'deletes shout' do
      create_user_shouts
      expect(Shout.all.count).to eq(2)
      delete '/shouts/1'
      expect(Shout.all.count).to eq(1)
      expect(response).to redirect_to(dashboard_path)
    end
  end

end

def create_user_shouts
  FactoryBot.create(:shout, :text_shout, user: user)
  FactoryBot.create(:shout, :photo_shout, user: user)
end