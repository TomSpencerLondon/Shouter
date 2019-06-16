module UsersHelper
  def follow_button(user)
    if current_user.following?(user)
      link_to 'Unfollow', user_follow_path(user), class: "btn btn-primary", method: :delete
    else
      link_to 'Follow', user_follow_path(user), class: "btn btn-primary", method: :post
    end
  end
end
