require 'rails_helper'

describe ShoutBuilderService do
  let(:user) do
    FactoryBot.create(:user,
                      email: 'harry@harry.com',
                      username: 'Harry',
                      password_digest: 'Testing123')
  end

  let(:shout_params) do
    params = ActionController::Parameters.new(body: 'Hello! This is a new Shout!')
    params.permit!
  end

  let(:klass){ TextShout }

  let(:shout_builder_service) do
    described_class.new(klass, shout_params, user)
  end

  it '#new creates an instance' do
    expect(shout_builder_service.instance_of?(ShoutBuilderService)).to eq(true)
  end

  context 'klass is TextShout' do
    it '#shout creates a text_shout' do
      shout_builder_service.shout
      expect(user.shouts.first.content.class).to eq(TextShout)
    end
  end

  context 'klass is PhotoShout' do
    let(:shout_params) do
      file_name = "dice.png"
      file_path = Rails.root.join('spec', 'fixtures', file_name)
      content_type = "image/png"
      uploaded_image = Rack::Test::UploadedFile.new(file_path, content_type)
      params = ActionController::Parameters.new(image: uploaded_image)
      params.permit!
    end

    let(:klass) { PhotoShout }

    it '#shout creates a photo_shout' do
      shout_builder_service.shout
      expect(user.shouts.first.content.class).to eq(PhotoShout)
    end
  end
end
