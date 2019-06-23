describe HashTagsController, type: :request do
  include LoginHelpers

  let(:user) do
    FactoryBot.create(:user,
                      email: "lewis@lewis.com",
                      password_digest: "Testing123",
                      username: "lewis")
  end

  let(:text_shout) do
    FactoryBot.create(:text_shout,
                      id: 1,
                      body: "#hello. This is a text shout")
  end

  let!(:shout) do
    FactoryBot.create(:shout, user: user, content: text_shout)
  end

  describe 'show' do
    before do
      sign_up_and_login
      get '/hash_tags/hello'
    end

    it 'showing hashtag search succeeds' do
      expect(response.status).to eq(200)
    end

    it 'shows the result on page' do
      expect(response.body).to include('#hello')
    end
  end

end
