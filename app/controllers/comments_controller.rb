class CommentsController < ApplicationController
  def create
    @comment = current_user.authored_comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        flash.now[:notice] = "Comment was successfully created."
        format.turbo_stream
      else
        flash[:error] = error_message(@comment)
        format.html { redirect_to request.referer }
      end
    end
  end

  def update
    @comment = current_user.authored_comments.find(params.expect(:id))

    if @comment.update(comment_params)
      flash.now[:notice] = "Comment was successfully updated."
    else
      flash[:error] = error_message(@comment)
    end

    redirect_to request.referer
  end

  def destroy
    @comment = current_user.authored_comments.find(params[:id])

    deletion_method = @comment.comments.any? ? :soft_delete! : :destroy!

    respond_to do |format|
      if @comment.send(deletion_method)
        flash.now[:notice] = "Comment was successfully destroyed."
        format.turbo_stream
      else
        flash[:error] = error_message(@comment)
        format.html { redirect_to request.referer }
      end
    end
  end

  private

  def comment_params
    params.expect(comment: [ :commentable_id, :commentable_type, :body, :top_level_post_id ])
  end

  def error_message(comment)
    "Failed with:\n\n#{@comment.errors.full_messages.to_sentence}"
  end
end
