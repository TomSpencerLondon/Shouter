# frozen_string_literal: true

require 'rails_helper'

describe HomesController, type: :request do
  include LoginHelpers

  describe 'show' do
    context 'user signed in' do
      it 'redirects to dashboard' do
        sign_up_and_login
        get '/'
        expect(response).to redirect_to(dashboard_path)
      end
    end

    context 'user not signed in' do
      it 'redirects to sign up' do
        get '/'
        expect(response.body.include?('Sign Up')).to eq(true)
      end
    end
  end
end
