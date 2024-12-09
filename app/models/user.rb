class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: %i[github]

  has_many :omniauth_logins, dependent: :destroy

  has_one :profile, dependent: :destroy
  delegate :username, :display_name, :avatar, to: :profile

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


  def self.from_omniauth(auth)
    login = OmniauthLogin.find_or_create_by(provider: auth.provider, uid: auth.uid)
    user = login.user || User.find_by(email: auth.info.email.downcase)

    if user.nil?
      user = User.new
      if auth.info.email.present?
        user.email = auth.info.email
        user.password = Devise.friendly_token
      end
      user.omniauth_logins << login
      user.save!
    else
      user.omniauth_logins << login
    end

    user

    # If you are using confirmable and the provider(s) you use validate emails,
    # uncomment the line below to skip the confirmation emails.
    # user.skip_confirmation!
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  private

  def email_required?
    super && omniauth_logins.none?
  end

  def password_required?
    super && omniauth_logins.none?
  end
end
