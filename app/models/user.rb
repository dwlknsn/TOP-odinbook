class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  has_one :profile, dependent: :destroy
  delegate :username, :display_name, :avatar, to: :profile

  before_create :create_profile

  private

  def create_profile
    build_profile(
      username: email.split("@").first,
      display_name: email.split("@").first
    )
  end
end
