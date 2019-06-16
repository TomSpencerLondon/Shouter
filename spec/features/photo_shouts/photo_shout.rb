require 'rails_helper'

describe "Photo Shout" do 
  include LoginHelpers
  include ShoutHelpers

  it 'photo_shout image shows modal when clicked', js: true do
    feature_sign_up_and_login
    add_photo_shout
    find('#photo-shout-1').click()
    expect(page).to have_css('.modal-content')
  end
end