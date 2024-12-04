class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable


  has_one :profile, dependent: :destroy
  delegate :username, :display_name, :avatar, to: :profile

  after_create :create_basic_profile

  has_many :authored_posts, class_name: "Post", inverse_of: :author, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, class_name: "Post", source: :likeable, source_type: "Post"

  has_many :authored_comments, class_name: "Comment", foreign_key: :author_id, inverse_of: :author, dependent: :destroy
  has_many :commented_posts, through: :authored_comments, class_name: "Post", source: :commentable, source_type: "Post"

  # users that you follow, i.e. you are the follower
  has_many :followings_as_follower, class_name: "Following", foreign_key: :follower_id, dependent: :destroy
  has_many :followees, through: :followings_as_follower

  # users that follow you, i.e. you are the followee
  has_many :followings_as_followee, class_name: "Following", foreign_key: :followee_id, dependent: :destroy
  has_many :followers, through: :followings_as_followee

  private

  def create_basic_profile
    sanitized_email = email.split("@").first.gsub(/\W/, "").downcase

    create_profile!(
      username: sanitized_email,
      display_name: sanitized_email
    )
  end
end
