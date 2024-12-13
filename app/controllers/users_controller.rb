class UsersController < ApplicationController
  def index
    @users = User.joins(:profile).includes([ :profile, :followees, :followings_as_follower ])
      .where.not(id: current_user.id)
      .where.not(id: current_user.followings_as_follower.blocked.select(:followee_id))
  end

  def show
    scope = User.includes([ :profile, :followees, :authored_posts ])
      .where.not(id: current_user.followings_as_follower.blocked.select(:followee_id))

    @user = scope.find(params[:id])

    @posts = @user.authored_posts.published.order(id: :desc)

  rescue
    redirect_to users_path, alert: "User not found"
  end
end
