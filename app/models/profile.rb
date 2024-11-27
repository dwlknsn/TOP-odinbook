class Profile < ApplicationRecord
  belongs_to :user

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 32 },
                       format: { with: /\A[a-zA-Z0-9]+\Z/, message: "Must contains only letters or numbers" }
  validates :display_name, presence: true,
                           length: { minimum: 3, maximum: 32 }

  has_one_attached :avatar
end
