class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable


  has_one :profile, dependent: :destroy
  delegate :username, :display_name, :avatar, to: :profile

  after_create :create_basic_profile

  has_many :authored_posts, class_name: "Post", inverse_of: :author, dependent: :destroy


  private

  def create_basic_profile
    sanitized_email = email.split("@").first.gsub(/\W/, "").downcase

    create_profile!(
      username: sanitized_email,
      display_name: sanitized_email
    )
  end
end
