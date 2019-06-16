require 'rails_helper'

describe "Session" do 
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
end
