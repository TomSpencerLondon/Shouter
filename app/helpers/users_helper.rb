module UsersHelper
  def follow_button(user)
    if current_user.following?(user)
      link_to 'Unfollow', user_follow_path(user), class: "btn btn-primary", id: "unfollow-button-user-#{user.id}", method: :delete
    else
      link_to 'Follow', user_follow_path(user), class: "btn btn-primary", id: "follow-button-user-#{user.id}", method: :post
    end
  end
end
