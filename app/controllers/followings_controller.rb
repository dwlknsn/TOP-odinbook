class FollowingsController < ApplicationController
  before_action :set_follower
  before_action :set_followee

  def create
    following = current_user.follower_followings.build(followee: @user)

    if following.save
      flash[:notice] = "Request to follow #{@user.display_name} sent."
    else
      flash[:error] = following.errors.full_messages.join(", ")
    end

    redirect_to request.referer
  end

  def destroy
    following = current_user.follower_followings.find_by(followee: @user)

    if following.destroy
      flash[:notice] = "You no longer follow #{@user.display_name}"
    else
      flash[:error] = following.errors.full_messages.join(", ")
    end

    redirect_to request.referer
  end

  def accept
    following = current_user.follower_followings.find_by(follower: @user)

    if following.accept!
      flash[:notice] = "Follow request from #{@user.display_name} accepted"
    else
      flash[:error] = following.errors.full_messages.join(", ")
    end

    redirect_to request.referer
  end

  def decline
    following = current_user.follower_followings.find_by(follower: @user)

    if following.decline!
      flash[:notice] = "Follow request from #{@user.display_name} declined"
    else
      flash[:error] = following.errors.full_messages.join(", ")
    end

    redirect_to request.referer
  end

  def block
    following = current_user.follower_followings.find_by(follower: @user)

    if following.block!
      flash[:notice] = "#{@user.display_name} blocked"
    else
      flash[:error] = following.errors.full_messages.join(", ")
    end

    redirect_to request.referer
  end

  private

  def set_follower
    current_user
  end

  def set_followee
    @user = User.find(params[:user_id])
  end
end
