class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id, inverse_of: :authored_posts
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_rich_text :content

  enum :status, {
    draft: 0,
    published: 1,
    archived: 2
  }, default: :draft

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :content, presence: true
  validates :status, presence: true

  scope :followed_by, ->(user) { where(author_id: user.followee_ids << user.id) }
  scope :discoverable_by, ->(user) { where.not(author_id: user.followee_ids).where.not(author_id: user.id) }
end
