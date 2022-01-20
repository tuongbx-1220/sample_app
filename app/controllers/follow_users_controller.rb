class FollowUsersController < ApplicationController
  before_action :find_user_by_id

  def following
    @title = t "Following"
    @pagy, @users = pagy @user.following, items: Settings.item_per_page
    render "users/show_follow"
  end

  def followers
    @title = t "Followers"
    @pagy, @users = pagy @user.followers, items: Settings.item_per_page
    render "users/show_follow"
  end
end
