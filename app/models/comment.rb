class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id", inverse_of: :authored_comments
  belongs_to :commentable, polymorphic: true
  belongs_to :top_level_post, class_name: "Post", foreign_key: "top_level_post_id", inverse_of: :all_comments, counter_cache: :all_comments_count
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable

  validates :body, presence: true

  after_create_commit :update_commentable_owner_notifications
  after_create_commit :auto_comment

  def soft_delete!
    update!(
      deleted_at: Time.now,
      body: "[DELETED]"
    )
  end

  def soft_deleted?
    deleted_at.present?
  end

  private

  def update_commentable_owner_notifications
    post = top_level_post
    target_dom_element = "#{ commentable.author.dom_id }-notifications-feed"

    broadcast_append_to(
      [ commentable.author, :notifications ],
      target: target_dom_element,
      partial: "notifications/comment",
      locals: { comment: self, post: post }
    )
  end

  def auto_comment
    AutomatedCommentJob.perform_later(self)
  end

  class Example
    MOVIES = [
      Faker::Movies::PrincessBride,
      Faker::Movies::Lebowski,
      Faker::Movies::BackToTheFuture,
      Faker::Movies::Ghostbusters,
      Faker::Movies::Hobbit,
      Faker::Movies::HarryPotter,
      Faker::Movies::LordOfTheRings,
      Faker::Movies::StarWars,
      Faker::Movies::Departed
    ]

    def self.create_for(commentable:, top_level_post:, author:)
      commentable.comments.create(
        top_level_post: top_level_post,
        author: author,
        body: MOVIES.sample.send(:quote)
      )
    end
  end
end
