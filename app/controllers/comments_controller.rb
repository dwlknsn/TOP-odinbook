class CommentsController < ApplicationController
  def create
    @comment = current_user.authored_comments.build(comment_params)

    respond_to do |format|
      if @comment.save
        flash[:notice] = "Comment was successfully created."
        format.turbo_stream
      else
        flash[:error] = "Failed with:\n\n#{@comment.errors.full_messages.join("\n")}"
        redirect_to request.referer
      end
    end
  end

  def update
    @comment = current_user.authored_comments.find(params.expect(:id))

    if @comment.update(comment_params)
      flash[:notice] = "Comment was successfully updated."
    else
      flash[:error] = "Failed with:\n\n#{@comment.errors.full_messages.join("\n")}"
    end

    redirect_to request.referer
  end

  def destroy
    @comment = current_user.authored_comments.find(params[:id])

    deletion_method = @comment.comments.any? ? :soft_delete! : :destroy!

    if @comment.send(deletion_method)
      flash[:notice] = "Comment was successfully destroyed."
    else
      flash[:error] = "Failed with:\n\n#{@comment.errors.full_messages.join("\n")}"
    end

    redirect_to request.referer
  end

  private

  def set_post
  end

  def comment_params
    params.expect(comment: [ :commentable_id, :commentable_type, :body ])
  end
end
