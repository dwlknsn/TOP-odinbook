class FollowingsController < ApplicationController
  before_action :set_follower
  before_action :set_followee

  def create
    following = current_user.follower_followings.build(followee: @user)

    # debugger

    if following.save
      flash[:notice] = "Request to follow #{@user.display_name} sent."
      redirect_to request.referer
    else
      flash[:error] = following.errors.full_messages.join(", ")
      redirect_to request.referer
    end
  end

  def destroy
    following = current_user.follower_followings.find_by(followee: @user)

    if following.destroy
      flash[:notice] = "You no longer follow #{@user.display_name}"
      redirect_to request.referer
    else
      flash[:error] = following.errors.full_messages.join(", ")
      redirect_to request.referer
    end
  end

  def accept
    following = current_user.follower_followings.find_by(follower: @user)

    if following.accept!
      redirect_to @user, notice: "Follow request from #{@user.display_name} accepted"
    else
      flash[:error] = following.errors.full_messages.join(", ")
      redirect_to @user
    end
  end

  def decline
    following = current_user.follower_followings.find_by(follower: @user)

    if following.decline!
      redirect_to @user, notice: "Follow request from #{@user.display_name} declined"
    else
      flash[:error] = following.errors.full_messages.join(", ")
      redirect_to @user
    end
  end

  def block
    following = current_user.follower_followings.find_by(follower: @user)

    if following.block!
      redirect_to @user, notice: "#{@user.display_name} blocked"
    else
      flash[:error] = following.errors.full_messages.join(", ")
      redirect_to @user
    end
  end

  private

  def set_follower
    current_user
  end

  def set_followee
    @user = User.find(params[:user_id])
  end
end
