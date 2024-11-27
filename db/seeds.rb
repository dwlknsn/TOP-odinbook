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
u = User.create!(
  email: "david@david.com",
  password: "password",
  password_confirmation: "password"
)

u.profile.update!(
  username: "davidsuperuser",
  display_name: "David Superuser"
)


movies = [
  Faker::Movies::BackToTheFuture,
  Faker::Movies::Ghostbusters,
  Faker::Movies::HitchhikersGuideToTheGalaxy,
  Faker::Movies::Lebowski,
  Faker::Movies::PrincessBride
]

movies.length.times do |n|
  email = Faker::Internet.unique.email
  puts "creating user: #{email}"

  u = User.create!(
    email: email,
    password: "password",
    password_confirmation: "password"
  )

  u.profile.update!(
    username: "user_#{n}",
    display_name: Faker::Name.name
  )

  # Create 3 posts for each user
  m = movies.shift
  3.times do
    quote = m.quote
    u.authored_posts.create!(
      title: quote.truncate_words(5),
      body: quote,
    )
  end
end
