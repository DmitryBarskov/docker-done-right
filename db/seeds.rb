# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Post.create!(
  title: "How to setup docker for development",
  body: "First I created `Dockerfile` with the next content:..."
)

User.create!(
  email: "user@example.org",
  first_name: "John",
  last_name: "Smith"
)
