# frozen_string_literal: true

require 'rails_helper'

describe UsersController, type: :request do
  include LoginHelpers
  describe 'index' do
    it 'request succeeds' do
      get '/users'
      expect(response.status).to eq(200)
    end
  end

  describe 'show' do
    it 'request succeeds' do
      sign_up_and_login
      get '/users/1'
      expect(response.status).to eq(200)
    end
  end

  describe 'new' do
    it 'request succeeds' do
      get '/users/new'
      expect(response.status).to eq(200)
    end
  end

  describe 'create' do
    it 'request succeeds' do
      post '/users', params: {
        user:
          {
            username: "Will",
            email: "will@will.com",
            password: "Testing123"
          }
      }
    end
  end
end
