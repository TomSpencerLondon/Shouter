require 'rails_helper'

describe DashboardService do
  let(:user) do
    FactoryBot.create(:user,
                      email: 'harry@harry.com',
                      username: 'Harry',
                      password_digest: 'Testing123')
  end

  let(:dashboard_service) do
    described_class.new(user)
  end

  it '#new creates an instance' do
    expect(dashboard_service.instance_of?(DashboardService)).to eq(true)
  end

  it '#new_text_shout returns TextShout' do
    text_shout = dashboard_service.new_text_shout
    expect(text_shout.class).to eq(TextShout)
  end

  it '#new_photo_shout returns TextShout' do
    photo_shout = dashboard_service.new_photo_shout
    expect(photo_shout.class).to eq(PhotoShout)
  end

  it '#timeline returns a Timeline instance' do
    timeline = dashboard_service.timeline
    expect(timeline.instance_of?(Timeline)).to eq(true)
  end
end
