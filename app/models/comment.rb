class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: "author_id", inverse_of: :authored_comments
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable
  has_many :comments, as: :commentable

  validates :body, presence: true, length: { minimum: 5 }

  def soft_delete!
    update!(
      deleted_at: Time.now,
      body: "[DELETED]"
    )
  end

  def soft_deleted?
    deleted_at.present?
  end
end
