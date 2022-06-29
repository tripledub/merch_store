# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
Product.create(code: 'MUG', name: 'Reedsy Mug', price: 6.00).tap do |mug|
  discount = 0
  quantity = 0
  while quantity < 150
    discount += 2
    quantity += 10

    DiscountRule.create(product: mug, code: mug.code, quantity:, discount:)
  end
end

Product.create(code: 'TSHIRT', name: 'Reedsy T-Shirt', price: 15.00).tap do |tshirt|
  DiscountRule.create(product: tshirt, code: tshirt.code, quantity: 3, discount: 30)
end

Product.create(code: 'HOODIE', name: 'Reedsy Hoodie', price: 20.00)
