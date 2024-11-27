class Profile < ApplicationRecord
  belongs_to :user

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 32 }
  validates :display_name, presence: true,
                           length: { minimum: 3, maximum: 32 }
end
