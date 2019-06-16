describe FollowingRelationshipsController, type: :request do
  include LoginHelpers

  let(:user) do
    FactoryBot.create(:user,
                      email: 'harry@harry.com',
                      username: 'Harry',
                      password_digest: 'Testing123')
  end

  describe 'create' do
    it 'following user succeeds' do
      sign_up_and_login
      post "/users/#{user.id}/follow"
      expect(response).to redirect_to(user_path(user))
      expect(flash[:notice]).to eq("Success! You are now following #{user.username}")
      expect(@controller.current_user.following?(user)).to eq(true)
    end
  end

  describe 'destroy' do
    it 'unfollowing user succeeds' do
      sign_up_and_login
      post "/users/#{user.id}/follow"
      expect(@controller.current_user.following?(user)).to eq(true)
      delete "/users/#{user.id}/follow"
      expect(@controller.current_user.following?(user)).to eq(false)
    end
  end
end
