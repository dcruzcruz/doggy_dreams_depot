require 'csv'

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

# Seed ContactPage
ContactPage.create!(title: 'Contact Us', content: Faker::Lorem.paragraphs(number: 3).join("\n"))

# Seed AboutPage
AboutPage.create!(title: 'About Us', content: Faker::Lorem.paragraphs(number: 3).join("\n"))

categories = ['Toys', 'Treats', 'Beds', 'Food', 'Apparel']

# Seed categories
categories.each do |category_name|
  Category.create(name: category_name)
end

# Seed a product
toy_category = Category.find_by(name: 'Toys')
Product.create!(
  product_name: 'Example Toy',
  description: 'This is an example toy product.',
  sku: 'TOY0041',
  price: 9.99,
  stock: 50,
  category: toy_category
).image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'products', 'TOY004.jpg')), filename: 'TOY004.jpg', content_type: 'image/jpg')

# Assuming your CSV file is named products.csv and located in the root directory of your Rails application
csv_file = Rails.root.join('lib', 'seeds', 'products.csv')

# Parse the CSV file and create products
CSV.foreach(csv_file, headers: true) do |row|
  category_id = row['category_id'].to_i
  category = Category.find_by(id: category_id)

  next if category.nil? # Skip if category not found

  product_attributes = {
    product_name: row['product_name'],
    description: row['description'],
    sku: row['sku'],
    price: row['price'].to_f,
    stock: row['stock'].to_i,
    category: category
  }

  product = Product.create!(product_attributes)

  # Attach image if image is provided
  if row['image'].present?
    product.image.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'products', row['image'])), filename: row['image'], content_type: 'image/jpeg')
  end
end

