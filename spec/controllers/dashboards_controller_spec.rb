describe DashboardsController, type: :request do
  include LoginHelpers

  describe 'create' do
    it 'following user succeeds' do
      sign_up_and_login
      get '/dashboard'
      expect(response.status).to eq(200)
      expect(response.body.include?("Welcome Will")).to eq(true)
    end
  end
end
