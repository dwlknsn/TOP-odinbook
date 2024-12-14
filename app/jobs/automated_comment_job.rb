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

  def perform(commentable)
    post = commentable.top_level_post
    return if post.all_comments_count >= 6

    users = User.first(5).sample(2)

    users.each do |user|
      sleep(7)
      commentable.comments.create!(
        author: user,
        top_level_post: post,
        body: MOVIES.sample.send(:quote)
      )
    end
  end
end
