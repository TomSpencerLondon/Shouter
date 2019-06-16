require 'rails_helper'

describe "Dashboard" do
  include LoginHelpers
  include ShoutHelpers

  describe 'show' do
    it 'shows username tab in navbar' do
      feature_sign_up_and_login
      expect(page).to have_css('#welcome-user')
    end

    it 'user can press button to sign out' do
      feature_sign_up_and_login
      find('#sign-out-button').click()
      expect(page.body.include?('Sign Up')).to eq(true)
    end

    it 'shows a form for text_shout and photo_shout' do
      feature_sign_up_and_login
      expect(page).to have_css('#shout-form')
      expect(page).to have_css('#photo-shout-form')
    end

    it 'text_shout submission succeeds' do
      feature_sign_up_and_login
      add_text_shout
      expect(page.body.include?("Hello! This is a new text shout.")).to eq(true)
    end

    it 'photo_shout submission succeeds' do
      feature_sign_up_and_login
      add_photo_shout
      expect(page).to have_xpath("//img[contains(@src,'dice.png')]")
    end
  end
end