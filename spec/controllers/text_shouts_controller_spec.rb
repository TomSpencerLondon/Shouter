# frozen_string_literal: true

require 'rails_helper'

describe TextShoutsController, type: :request do
  include LoginHelpers

  describe 'create with shout body' do
    it 'uploads shout and redirects' do
      sign_up_and_login
      post '/text_shouts', params: {
                                    text_shout: {
                                      body: "Hello! This is a new text_shout."
                                      }
                                    }
      expect(response).to redirect_to(dashboard_path)
      expect(Shout.all.count).to eq(1)
    end
  end

  describe 'create without shout body' do
    it 'adds flash message and redirects' do
      sign_up_and_login
      post '/text_shouts', params: {
                                    text_shout: {
                                      body: ""
                                      }
                                    }
      expect(response).to redirect_to(dashboard_path)
      expect(Shout.all.count).to eq(0)
      expect(flash[:alert]).to eq("Could not shout.")
    end
  end
end
