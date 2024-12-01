class LikesController < ApplicationController
  def create
    @like = current_user.likes.build(like_params)

    respond_to do |format|
      if @like.save
        format.turbo_stream
      else
        flash[:error] = error_message(@like)
        format.html { redirect_to request.referer }
      end
    end
  end

  def destroy
    @like = current_user.likes.find(params[:id])

    respond_to do |format|
      if @like.destroy
        format.turbo_stream
      else
        flash[:error] = error_message(@like)
        format.html { redirect_to request.referer }
      end
    end
  end

  private

  def like_params
    @like_params ||= params.expect(like: [ :likeable_id, :likeable_type ])
  end

  def error_message(like)
    "Failed with:\n\n#{@like.errors.full_messages.to_sentence}"
  end
end
