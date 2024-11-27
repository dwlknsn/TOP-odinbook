class Profile < ApplicationRecord
  belongs_to :user

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 32 },
                       format: { with: /\A[\w]+\Z/, message: "Must contains only letters, numbers, or underscores" }
  validates :display_name, presence: true,
                           length: { minimum: 3, maximum: 32 }

  has_one_attached :avatar
end
