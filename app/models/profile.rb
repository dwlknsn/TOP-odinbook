class Profile < ApplicationRecord
  belongs_to :user

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 15 },
                       format: { with: /\A\w{3,15}\z/, message: "Must contains only letters, numbers, or underscores" }
  validates :display_name, presence: true,
                           length: { minimum: 3, maximum: 32 },
                           format: { with: /\A[\w\s]{3,32}\z/, message: "Must contains only letters, numbers, underscores, or spaces" }

  has_one_attached :avatar

  before_validation :sanitize_display_name
  after_create_commit :send_new_registration_email

  private

  def send_new_registration_email
    UserMailer.with(user: user).new_registration.deliver_now
  end

  def sanitize_display_name
    self.display_name = display_name.strip.gsub(/\s{2,}/, " ")
  end
end
