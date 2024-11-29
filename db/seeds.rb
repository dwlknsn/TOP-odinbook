# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# My user
puts "Creating superuser"
u = User.create!(
  email: "david@david.com",
  password: "password",
  password_confirmation: "password"
)

u.profile.update!(
  username: "davidsuperuser",
  display_name: "David Superuser"
)

5.times do |n|
  email = Faker::Internet.unique.email
  puts "creating user: #{email}"

  u = User.create!(
    email: email,
    password: "password",
    password_confirmation: "password"
  )

  u.profile.update!(
    username: "user_#{n + 1}",
    display_name: Faker::Name.name
  )
end

puts "Creating posts"
User.all.each do |user|
  10.times do
    user.authored_posts.create!(
      title: Faker::Lorem.sentence(word_count: 5),
      body: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
      )
    end
  end

puts "Creating comments, likes, and follows"
User.all.each do |user|
  posts = Post.where.not(author: user).sample(4)

  posts.each do |post|
    post.comments.create(author: user, body: Faker::Movies::PrincessBride.quote)
    post.likes.create(user: user)
  end

  posts.map(&:author).uniq.each do |author|
    author.followers << user
  end
end
