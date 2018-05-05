# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#   Generate Admin
User.create(
  name:'Admin',
  email:'admin@example.com',
  password:'12345678',
  role:'admin',
  description:'I am Admin'
  )

puts "Admin was generated!"

#   Generate Categories

categories = ['Ruby','Rails','CSS','HTML','GIT','Javascript']

Category.destroy_all

for i in 0..5
  Category.create( name: categories[i])
  puts "Category #{categories[i]} was generated!"
end
