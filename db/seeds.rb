# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 200.times do |n|
#   title =
#   content = Faker::Lorem.sentence
#   expired_at = Faker::Date.between(from: Date.today, to: 1.year.from_now)
#   status = rand(1..3)
#   priority = rand(1..3)
#
#   Task.create!(title: title, content: content, expired_at: expired_at, status: status, priority: priority )
# end

User.create!(
  name: "admin",
  email: "admin@test.com",
  password: "password"
)

5.times do |n|
  name = "test#{n}"
  email = "test#{n}@test.com"
  password = "password"

  User.create!(name: name, email: email, password: password)
end
