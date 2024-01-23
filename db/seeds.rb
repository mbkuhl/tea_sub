# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

t1= Tea.create!(title: "Hygge", description: "Chinese black tea", temperature: 90, brew_time: 3)
t2= Tea.create!(title: "Green Tea", description: "Lower Caffeine with a lighter flavor", temperature: 80, brew_time: 3)
t3= Tea.create!(title: "Lemon Ginger", description: "No caffeine, with a bite", temperature: 100, brew_time: 7)

customer1 = Customer.create!(first_name: "fname1", last_name: "lname1", email: "cust1@gmail.com", address: "111 Fake Streer Denver, CO 00000")
customer2 = Customer.create!(first_name: "fname2", last_name: "lname2", email: "cust2@gmail.com", address: "222 Fake Streer Denver, CO 00000")

Subscription.create!(title: "Hygge Sub", price: 10, status: 0, frequency: 30, customer_id: customer1.id, tea_id: t1.id)
Subscription.create!(title: "Green Tea Sub", price: 12, status: 1, frequency: 60, customer_id: customer1.id, tea_id: t2.id)
Subscription.create!(title: "Lemon Ginger Sub", price: 6, status: 0, frequency: 7, customer_id: customer2.id, tea_id: t3.id)