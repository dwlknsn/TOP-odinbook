class AutomatedCommentJob < ApplicationJob
  queue_as :default

  MOVIES = [
    Faker::Movies::PrincessBride,
    Faker::Movies::Lebowski,
    Faker::Movies::BackToTheFuture,
    Faker::Movies::Ghostbusters,
    Faker::Movies::Hobbit,
    Faker::Movies::HarryPotter,
    Faker::Movies::LordOfTheRings,
    Faker::Movies::StarWars,
    Faker::Movies::Departed
  ]

  def perform(post)
    abort if Comment.where(top_level_post: post).count >= 6

    users = User.first(5).sample(2)

    users.each do |user|
      sleep(5)
      post.comments.create!(
        author: user,
        top_level_post: post,
        body: MOVIES.sample.send(:quote)
      )
    end
  end
end
