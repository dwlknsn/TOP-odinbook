class AutomatedCommentJob < ApplicationJob
  queue_as :default

  def perform(commentable)
    top_level_post = commentable.top_level_post
    return if top_level_post.all_comments_count >= 6

    users = User.where.not(id: commentable.author_id).first(4).sample(2)

    users.shuffle.each do |user|
      sleep(7)

      Comment::Example.create_for(
        commentable: commentable,
        top_level_post: top_level_post,
        author: user
      )
    end
  end
end
