# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Delete existing AdminUser in development
AdminUser.where(email: 'admin@example.com').destroy_all if Rails.env.development?

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

5.times do
  Category.create(name: Faker::Creature::Animal.unique.name)
end

# Seed products
11.times do
  category = Category.order("RANDOM()").first
  product = Product.create(
    product_name: Faker::Commerce.product_name,
    description: Faker::Lorem.paragraph(sentence_count: 2),
    price: Faker::Commerce.price(range: 10.0..100.0),
    stock: Faker::Number.between(from: 0, to: 100),
    category_id: category.id
  )
end