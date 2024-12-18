class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id, inverse_of: :authored_posts
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :all_comments, class_name: "Comment", foreign_key: "top_level_post_id", inverse_of: :top_level_post
  has_rich_text :content

  enum :status, {
    draft: 0,
    published: 1,
    archived: 2
  }, default: :draft

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :content, presence: true
  validates :status, presence: true

  scope :followed_by, ->(user) {
    where(author_id: user.followings_as_follower.where(status: :accepted).select(:followee_id))
  }

  scope :discoverable_by, ->(user) {
    where.not(author_id: user.followings_as_follower.where(status: [ :accepted, :blocked ]).select(:followee_id))
    .where.not(author_id: user.id)
  }

  before_commit :set_published_at_when_publishing
  after_commit :auto_like
  after_commit :auto_comment

  def top_level_post
    self
  end

  private

  def set_published_at_when_publishing
    return unless status_previously_changed? && status == "published"

    self.published_at = Time.current
  end

  def auto_like
    return unless status_previously_changed? && status == "published"

    AutomatedLikeJob.perform_later(self)
  end

  def auto_comment
    return unless status == "published"

    AutomatedCommentJob.perform_later(self)
  end
end
