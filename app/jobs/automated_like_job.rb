class AutomatedLikeJob < ApplicationJob
  queue_as :default

  def perform(likeable)
    users = User.where.not(id: likeable.author_id).first(4).sample(3)
    likeable.likes.where(user: users).destroy_all

    users.shuffle.each do |user|
      sleep(5)
      likeable.likes.create!(user: user)
    end
  end
end
