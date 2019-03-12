# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


5.times do
	user = User.create!(
		email: "mimi#{rand(1..1000)}@yopmail.com",
		password: "test1234",
	)
end

name_category = ["Soins bébé", "Chaises hautes & sièges auto", "Poussettes", "Mobilier enfant", "Jeux & Jouets", "Livres & Scolarité", "Sécurité", "Allaitement & Repas", "Vêtements"]

name_category.each do |i|
  Category.create!(
    title: i
  )
end
