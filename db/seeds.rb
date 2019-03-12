require "faker"

Profile.destroy_all
User.destroy_all

name_category = ["Soins bébé", "Chaises hautes & sièges auto", "Poussettes", "Mobilier enfant", "Jeux & Jouets", "Livres & Scolarité", "Sécurité", "Allaitement & Repas", "Vêtements"]

name_email = ["bastien.hiel@yopmail.com", "claudia.partonneau@yopmail.com", "maxime.speroni@yopmail.com", "viviane.depetigny@yopmail.com", "melanie.nguon@yopmail.com"]

first_names = ["Bastien", "Claudia", "Maxime", "Viviane", "Mélanie"]
last_names = ["Hiel", "Partonneau", "Speroni", "Depetigny", "Nguon"]

i = 0
1.times do
	user = User.create!(
		email: name_email[i],
		password: "test1234",
	)
	i += 1
end
puts '1 user have been seeded'

name_category.each do |i|
  Category.create!(
    title: i
  )
end
puts '1 category have been seeded'

j = 0
5.times do
	profile = Profile.create!(
		first_name: first_names[j],
		last_name: last_names[j],
		phone_number: "06#{rand(10000000..99999999)}",
		street: "#{rand(1..100)} Avenue Kléber",
		city: "Paris",
		zip_code: "75016",
		country: "France",
		description: "Un super être humain qui est tout le temps positif à propos de tout!",
		user: User.all.sample
	)
	j += 1
end
puts '5 profile have been seeded'

20.times do
	product = Product.create!(
		title: Faker::Vehicle.manufacture,
		price: rand(19..99),
		description: Faker::ChuckNorris.fact,
		brand: Faker::Beer.brand,
		color: Faker::Color.color_name,
		size: rand(1..12),
		seller: User.all.sample,
		category: Category.all.sample,
	)
end
puts '20 products have been seeded'
