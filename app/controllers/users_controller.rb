class UsersController < ApplicationController
  def index
    @users = User.includes([ :profile, :followees, :followings_as_follower ]).where.not(id: current_user.id)
  end

  def show
    @user = User.includes([ :profile, :followees, :authored_posts ]).find(params[:id])
  end
end
