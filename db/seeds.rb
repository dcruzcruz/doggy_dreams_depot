require 'csv'
Province.destroy_all
Category.destroy_all
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

# Seed a provinces
Province.create(name: "Alberta", gst_rate: 5, pst_rate: 0, hst_rate: 0)
Province.create(name: "British Columbia", gst_rate: 5, pst_rate: 7, hst_rate: 0)
Province.create(name: "Manitoba", gst_rate: 5, pst_rate: 7, hst_rate: 0)
Province.create(name: "New Brunswick", gst_rate: 0, pst_rate: 0, hst_rate: 15)
Province.create(name: "Newfoundland and Labrador", gst_rate: 0, pst_rate: 0, hst_rate: 15)
Province.create(name: "Northwest Territories", gst_rate: 5, pst_rate: 0, hst_rate: 0)
Province.create(name: "Nova Scotia", gst_rate: 0, pst_rate: 0, hst_rate: 15)
Province.create(name: "Nunavut", gst_rate: 5, pst_rate: 0, hst_rate: 0)
Province.create(name: "Ontario", gst_rate: 0, pst_rate: 0, hst_rate: 13)
Province.create(name: "Prince Edward Island", gst_rate: 0, pst_rate: 0, hst_rate: 15)
Province.create(name: "Quebec", gst_rate: 5, pst_rate: 9.975, hst_rate: 0)
Province.create(name: "Saskatchewan", gst_rate: 5, pst_rate: 6, hst_rate: 0)
Province.create(name: "Yukon", gst_rate: 5, pst_rate: 0, hst_rate: 0)
# Assuming your CSV file is named products.csv and located in the root directory of your Rails application
csv_file = Rails.root.join('lib', 'seeds', 'products.csv')

# Parse the CSV file and create products
CSV.foreach(csv_file, headers: true) do |row|
  category_id = row['category_id'].to_i
  category = Category.find_by(id: category_id)

  if category.nil?
    puts "Category with ID #{category_id} not found for product #{row['product_name']}. Skipping..."
    next
  end

  product_attributes = {
    product_name: row['product_name'],
    description: row['description'],
    sku: row['sku'],
    price: row['price'].to_f,
    stock: row['stock'].to_i,
    category: category
  }

  product = Product.new(product_attributes)

  # Attach image if image is provided
  if row['image'].present?
    image_path = Rails.root.join('app', 'assets', 'images', 'products', row['image'])
    if File.exist?(image_path)
      product.image.attach(io: File.open(image_path), filename: row['image'], content_type: 'image/jpeg')
    else
      puts "Image file #{row['image']} not found for product #{row['product_name']}. Skipping..."
    end
  end

  if product.save
    puts "Product '#{product.product_name}' created successfully."
  else
    puts "Failed to create product '#{product.product_name}': #{product.errors.full_messages.join(', ')}"
  end
end
