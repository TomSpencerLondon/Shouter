# frozen_string_literal: true

require 'rails_helper'

describe PhotoShoutsController, type: :request do
  include LoginHelpers

  let(:uploaded_image) do
    file_name = "dice.png"
    file_path = Rails.root.join('spec', 'fixtures', file_name)
    content_type = "image/png"
    Rack::Test::UploadedFile.new(file_path, content_type)
  end

  describe 'create with shout photo' do
    it 'uploads the photo_shout' do
      sign_up_and_login
      post '/photo_shouts', params: { 
                                      photo_shout: {
                                                    image: uploaded_image
                                                   }
                                    }
      expect(Shout.all.count).to eq(1)
      expect(Shout.first.content_type).to eq("PhotoShout")
      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe 'create with shout photo' do
    it 'uploads the photo_shout' do
      sign_up_and_login
      post '/photo_shouts', params: { 
                                      photo_shout: {
                                                    image: ""
                                                   }
                                    }
      expect(Shout.all.count).to eq(0)
      expect(response).to redirect_to(dashboard_path)
      expect(flash[:alert]).to eq("Could not shout.")
    end
  end
end
