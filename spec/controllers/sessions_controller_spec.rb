# frozen_string_literal: true

require 'rails_helper'

describe TextShoutsController, type: :request do
  include LoginHelpers
  describe 'create with signed up user' do
    it 'starts a new session' do
      sign_up_and_login
      logout
      post '/session', params: {
                                session: {
                                  email: "will@will.com",
                                  password: "Testing123"
                                }
                              }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'create with strange user' do
    it 'renders the new session page' do
      post '/session', params: {
                                session: {
                                  email: "danny@danny.com",
                                  password: "Testing123"
                                }
                              }
      expect(response.body.include?('Sign up')).to eq(true)
    end
  end
end
