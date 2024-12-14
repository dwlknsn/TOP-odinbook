# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts
puts "Creating users"
%w[ david billy bobby tammy tommy ziggy].each do |name|
  email = "#{name}@d.com"
  print "."

  u = User.create!(
    email: email,
    password: "password",
    password_confirmation: "password"
  )

  u.create_profile!(
    username: name,
    display_name: "#{name}-#{Faker::Name.name}"
  )
end

puts
puts "Creating posts"
User.all.each do |user|
  10.times do
    print "."
    user.authored_posts.create!(
      title: Faker::Lorem.sentence(word_count: 5),
      content: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
    )
  end

  user.authored_posts.sample(5).each(&:published!)
end

puts
puts "Creating comments, likes, and follows"
User.all.each do |user|
  posts = Post.published.where.not(author: user).sample(20)

  posts.each do |post|
    print "."

    Comment::Example.create_for(
      commentable: post,
      top_level_post: post,
      author: user
    )
    post.likes.create(user: user)
  end

  User.where.not(id: user.id).sample(3).each do |follower|
    user.followers << follower
  end

  user.followings_as_followee.first.accepted!
end
