require 'rails_helper'

describe "Users" do
  include LoginHelpers
  include ShoutHelpers

  before do
    feature_sign_up_and_login
  end

  let!(:user_two) do
    FactoryBot.create(:user,
                      email: 'harry@harry.com',
                      username: 'Harry',
                      password_digest: 'password123')
  end

  let!(:text_shout) do
    FactoryBot.create(:shout,
                      :text_shout,
                      user: user_two)
  end

  let!(:photo_shout) do
    FactoryBot.create(:shout,
                      :photo_shout,
                      user: user_two)
  end

  context 'index' do
    it 'page works' do
      visit '/users'
      expect(page.body).to have_css('.users.index')
    end

    it '#show-user-button-2 shows user with follow button' do
      visit '/users'
      find('#show-user-button-2').click()
      expect(page.body).to have_css('.users.show')
      expect(page.body).to have_css('#follow-button-user-2')
    end
  end

  context 'show' do
    context 'following' do
      before do
        visit '/users'
        find('#show-user-button-2').click()
        find('#follow-button-user-2').click()
      end

      it 'follow button adds users shouts to current_user timeline' do
        expect(page.body).to include("Success! You are now following #{user_two.username}")
        visit '/dashboard'
        expect(page.body).to have_css('#shout_1')
      end

      it 'current_user can follow and unfollow' do
        expect(page.body).to include("Success! You are now following #{user_two.username}")
        find("#unfollow-button-user-2").click()
        expect(page.body).to include("Ok! You are no longer following #{user_two.username}")
      end
    end

    context 'clicking modal' do
      before do
        visit '/users/2'
      end

      it 'current_user can click modal for photo_shouts', js: true do
        find('#photo-shout-1').click()
        expect(page.body).to have_css('#open-modal-image')
      end
    end
  end
end
