class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates :user_id, presence: true
  validates :user_id, uniqueness: { scope: [ :likeable_id, :likeable_type ] }
  validate :user_cannot_like_own_likeable

  private

  def user_cannot_like_own_likeable
    return unless user == likeable.author
    errors.add(:user, "cannot like own #{likeable_type}")
  end
end
