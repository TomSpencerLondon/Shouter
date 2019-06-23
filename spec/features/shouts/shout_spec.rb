require 'rails_helper'

describe "Shouts" do
  include LoginHelpers
  include ShoutHelpers

  context 'text_shout' do
    before do
      feature_sign_up_and_login
      add_text_shout("Hello! This is a new text shout.")
    end

    it 'has links and content' do
      expect(page.body.include?("Hello! This is a new text shout.")).to eq(true)
      expect(page).to have_css('#primary-shout-user-link-1')
      expect(page).to have_css('#secondary-shout-user-link-1')
      expect(page).to have_css('#shout-link-1')
    end

    it '#primary-shout-user-link goes to user show page' do
      find('#primary-shout-user-link-1').click()
      expect(page.body).to have_css('.users.show')
    end

    it '#secondary-shout-user-link-1 goes to user show page' do
      find('#primary-shout-user-link-1').click()
      expect(page.body).to have_css('.users.show')
    end

    it '#shout-link-1 goes to user show page' do
      find('#shout-link-1').click()
      expect(page.body).to have_css('.shouts.show')
    end
  end

  context 'photo_shout' do
    before do
      feature_sign_up_and_login
      add_photo_shout
    end

    it 'photo_shout submission succeeds' do
      expect(page).to have_xpath("//img[contains(@src,'dice.png')]")
      expect(page).to have_css('#photo-shout-1')
      expect(page).to have_css('#primary-shout-user-link-1')
      expect(page).to have_css('#secondary-shout-user-link-1')
      expect(page).to have_css('#shout-link-1')
    end

    it '#photo-shout-1 link shows modal', js: true do
      find('#photo-shout-1').click()
      expect(page).to have_css('#open-modal-image')
    end

    it '#primary-shout-user-link goes to user show page' do
      find('#primary-shout-user-link-1').click()
      expect(page.body).to have_css('.users.show')
    end

    it '#secondary-shout-user-link-1 goes to user show page' do
      find('#secondary-shout-user-link-1').click()
      expect(page.body).to have_css('.users.show')
    end

    it '#shout-link-1 goes to user show page' do
      find('#shout-link-1').click()
      expect(page.body).to have_css('.shouts.show')
    end
  end
end
