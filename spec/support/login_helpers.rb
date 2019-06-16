module LoginHelpers
  def sign_up_and_login
    post '/users', params: {
      user:
        {
          username: "Will",
          email: "will@will.com",
          password: "Testing123"
        }
    }
  end

  def logout
    delete '/session'
  end

  def feature_sign_up_and_login
    visit new_user_path
    find('input[name="user[username]"]').set("Tom")
    find('input[name="user[email]"]').set("tom@tom.com")
    find('input[name="user[password]"]').set("Password123")
    find('input[type="submit"]').click()
  end

  def feature_sign_up_and_sign_out
    feature_sign_up_and_login
    find('#sign-out-button').click()
  end
end
