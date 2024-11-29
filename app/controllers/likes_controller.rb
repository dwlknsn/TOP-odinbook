class LikesController < ApplicationController
  before_action :set_post

  def create
    like = @post.likes.build(user: current_user)

    if like.save
      flash[:notice] = "You liked this post"
    else
      flash[:error] = "failed"
    end

    redirect_to request.referer
  end

  def destroy
    like = current_user.likes.find(params[:id])

    if like.destroy
      flash[:notice] = "You removed a like from this post"
    else
      flash[:error] = "failed"
    end

    redirect_to request.referer
  end

  private

  def set_post
    @post = Post.find(params[:post_id])
  end

  rescue_from ActiveRecord::RecordNotUnique do |error|
    flash[:error] = "You already liked this post"
    # flash[:error] = error.message
    redirect_to request.referer
  end
end
