class FollowingsController < ApplicationController
  def create
    @following = current_user.followings_as_follower.build(following_params)
    @followee = @following.followee

    respond_to do |format|
      if @following.save
        flash.now[:notice] = "Follow request sent to #{@followee.display_name}"
        format.turbo_stream
      else
        flash[:error] = error_message(@following)
        format.html { redirect_to request.referer }
      end
    end
  end

  def update
    @following = current_user.followings_as_followee.find(params[:id])
    @followee = @following.followee

    respond_to do |format|
      if @following.update(following_params)
        flash.now[:notice] = "Follower #{@following.status}"
        format.turbo_stream
      else
        flash[:error] = error_message(@following)
        format.html { redirect_to request.referer }
      end
    end
  end

  def destroy
    @following = current_user.followings_as_follower.find(params[:id])
    @followee = @following.followee

    respond_to do |format|
      if @following.destroy
        flash.now[:notice] = "Follow request cancelled"
        format.turbo_stream
      else
        flash[:error] = error_message(@following)
        format.html { redirect_to request.referer }
      end
    end
  end

  private

  def following_params
    @following_params ||= params.expect(following: [ :followee_id, :status ])
  end

  def error_message(following)
    "Failed with:\n\n#{@following.errors.full_messages.to_sentence}"
  end
end
