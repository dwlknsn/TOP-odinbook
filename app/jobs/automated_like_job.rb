class AutomatedLikeJob < ApplicationJob
  queue_as :default

  def perform(likeable)
    users = User.first(4)
    likeable.likes.where(user: users).destroy_all

    users.each do |user|
      sleep(5)
      likeable.likes.create!(user: user)
    end
  end
end
