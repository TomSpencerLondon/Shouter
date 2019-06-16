require 'rails_helper'

describe "Navbar" do
  include LoginHelpers

  context 'user signed in' do
    describe 'navbar' do
      before do
        feature_sign_up_and_login
      end

      it 'shows user welcome links' do
        expect(page).to have_css('#dashboard-link')
        expect(page).to have_css('#users-link')
        expect(page).to have_css('#welcome-user')
        expect(page).to have_css('#sign-out-button')
      end

      it 'dasboard-link goes to dashboard' do
        find('#dashboard-link').click()
        expect(page).to have_css(".dashboards.show")
      end

      it 'users-link goes to users index' do
        find('#users-link').click()
        expect(page).to have_css(".users.index")
        expect(page).to have_css("#show-user-button-1")
      end

      it 'welcome-user goes to dashboard' do
        find('#welcome-user').click()
        expect(page).to have_css(".dashboards.show")
      end

      it 'sign-out goes to sign in form' do
        find('#sign-out-button').click()
        expect(page).to have_css(".homes.show")
        expect(page.body.include?('Sign Up')).to eq(true)
      end
    end
  end

  context 'user not signed in' do
    describe 'navbar' do
      before do
        visit root_path
      end

      it 'shows sign in links' do
        expect(page).to have_css('#root-link')
        expect(page).to have_css('#sign-in-link')
        expect(page).to have_css('#sign-up-link')
      end

      it 'root-link goes to sign in form' do
        find('#root-link').click()
        expect(page).to have_css(".homes.show")
        expect(page.body.include?('Log in')).to eq(true)
      end

      it 'sign-in-link goes to sign in form' do
        find('#sign-in-link').click()
        expect(page).to have_css(".sessions.new")
        expect(page.body.include?('Log in')).to eq(true)
      end

      it 'sign-up-link goes to sign up form' do
        find('#sign-up-link').click()
        expect(page).to have_css(".users.new")
        expect(page.body.include?('Sign up')).to eq(true)
      end
    end
  end
end
