class FollowingsController < ApplicationController
  before_action :set_following, only: [ :update, :destroy ]

  def create
    @following = Following.build(following_params)

    if @following.save
      flash[:notice] = "Request to follow #{@user.display_name} sent."
    else
      flash[:error] = error_message(@following)
    end

    redirect_to request.referer
  end

  def update
    if @following.update(following_params)
      flash[:notice] = "Accepted."
    else
      flash[:error] = error_message(@following)
    end

    redirect_to request.referer
  end

  def destroy
    if @following.destroy
      flash[:notice] = "You no longer follow #{@user.display_name}"
    else
      flash[:error] = error_message(@following)
    end

    redirect_to request.referer
  end

  private

  def set_following
    @following ||= Following.find_by(id: params[:id], follower: follower, followee: followee)
  end

  def following_params
    @following_params ||= params.expect(following: [ :follower_id, :followee_id, :status ])
  end

  def follower
    @follower ||= User.find(following_params[:follower_id])
  end

  def followee
    @followee ||= User.find(following_params[:followee_id])
  end

  def error_message(following)
    "Failed with:\n\n#{@following.errors.full_messages.to_sentence}"
  end
end
