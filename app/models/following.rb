class Following < ApplicationRecord
  belongs_to :followee, class_name: "User", foreign_key: :followee_id
  belongs_to :follower, class_name: "User", foreign_key: :follower_id

  enum :status, {
    requested: 0,
    accepted: 1,
    declined: 2,
    blocked: 3
  }, default: :requested

  validate :cannot_follow_self

  def accept!
    accepted!
  end

  def decline!
    declined!
  end

  def block!
    blocked!
  end

  private

  def cannot_follow_self
    return unless followee_id == follower_id
    errors.add(:followee_id, "cannot follow self")
  end
end
