class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true
  # can we add counter cache on a polymorphic column, e.g.
  # likeable_count, scope -> { :likeable_type, :likeable_id }

  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: [ :likeable_id, :likeable_type ] }
  validate :user_cannot_like_own_likeable

  after_create_commit :update_likeable_owner_notifications

  private

  def user_cannot_like_own_likeable
    return unless user == likeable.author
    errors.add(:user, "cannot like own #{likeable_type}")
  end

  def update_likeable_owner_notifications
    post = likeable_type == Post.name ? likeable : likeable.top_level_post

    broadcast_prepend_to(
      "#{ likeable.author.dom_id }-notifications",
      target: "#{ likeable.author.dom_id }-notifications-feed",
      partial: "notifications/like",
      locals: { like: self, post: post }
    )
  end
end
