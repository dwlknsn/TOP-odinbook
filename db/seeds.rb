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

5.times do |n|
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
end

def create_posts(user)
  3.times do
    user.authored_posts.create!(
      title: Faker::Lorem.sentence(word_count: 5),
      body: Faker::Lorem.paragraphs(number: 3).join("\n\n"),
    )
  end
end

User.all.each do |user|
  create_posts(user)
end
