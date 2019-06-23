describe SearchesController, type: :request do
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

  let(:text_shout_two) do
    FactoryBot.create(:text_shout,
                      id: 2,
                      body: "#goodbye. This is another text shout")
  end

  before do
    FactoryBot.create(:shout, :reindex, user: user, content: text_shout)
    FactoryBot.create(:shout, :reindex, user: user, content: text_shout_two)
  end

  describe 'show' do
    before do
      sign_up_and_login
      get '/search', params: {
                                search:{
                                        term: "hello"
                                        }
                              }
    end

    it 'search succeeds' do
      expect(response.status).to eq(200)
    end

    it 'shows the result on page' do
      expect(response.body).to include('#hello', 'This is a text shout')
    end

    it 'does not show other shout in database' do
      expect(response.body).not_to include('#goodbye', 'This is another text shout')
    end
  end

end