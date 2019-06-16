require 'rails_helper'

describe "Home" do 
  include LoginHelpers

  it 'user can sign in' do
    feature_sign_up_and_sign_out
    visit root_path
    find('input[name="session[email]"]').set("tom@tom.com")
    find('input[name="session[password]"]').set("Password123")
    find('input[type="submit"]').click()
    expect(page).to have_css('#shout-form')
    expect(page).to have_css('#photo-shout-form')
  end

  it 'user can click for sign up and complete sign up' do
    visit root_path
    page.click_link('Sign Up Here', :href => new_user_path)
    expect(page).to have_css('#new_user')
    find('input[name="user[username]"]').set("Jimmy")
    find('input[name="user[email]"]').set("jimmy@jimmy.com")
    find('input[name="user[password]"]').set("Password123")
    find('input[type="submit"]').click()

    expect(page).to have_css('#shout-form')
    expect(page).to have_css('#photo-shout-form')
  end
end