class LikesController < ApplicationController
  def create
    like = current_user.likes.build(like_params)

    if like.save
      flash[:notice] = "You liked this #{like.likeable_type}"
    else
      flash[:error] = "Failed with:\n\n#{like.errors.full_messages.join("\n")}"
    end

    redirect_to request.referer
  end

  def destroy
    like = current_user.likes.find(params[:id])

    if like.destroy
      flash[:notice] = "You removed a like from this #{like.likeable_type}"
    else
      flash[:error] = "Failed with:\n\n#{like.errors.full_messages.join("\n")}"
    end

    redirect_to request.referer
  end

  private

  def like_params
    @like_params ||= params.expect(like: [ :likeable_id, :likeable_type ])
  end
end
