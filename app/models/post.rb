class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id, inverse_of: :authored_posts
  has_many :likes, as: :likeable, dependent: :destroy

  enum :status, {
    draft: 0,
    published: 1,
    archived: 2
  }, default: :draft

  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :body, presence: true
  validates :status, presence: true
end
