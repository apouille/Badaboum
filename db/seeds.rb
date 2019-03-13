require "faker"
Child.destroy_all
Profile.destroy_all
User.destroy_all
Product.destroy_all
Category.destroy_all



categories = ["Soins bébé", 
	          "Chaises hautes & sièges auto", 
	          "Poussettes", "Mobilier enfant", 
	          "Jeux & Jouets", 
	          "Livres & Scolarité", 
	          "Sécurité", 
	          "Allaitement & Repas", 
	          "Vêtements"
	          ]

users = [
	["bastien.hiel@yopmail.com", "Bastien", "Hiel"],
	["claudia.partonneau@yopmail.com", "Claudia", "Partonneau"],
	["maxime.speroni@yopmail.com", "Maxime", "Speroni"],
	["viviane.depetigny@yopmail.com", "Viviane", "de Pétigny"],
	["melanie.nguon@yopmail.com", "Mélanie", "Nguon"]
]

users.each do |u|
	user = User.create!(
		email: u[0],
		password: "test1234",
	)
	profile = Profile.create!(
		first_name: u[1],
		last_name: u[2],
		phone_number: "06#{rand(10000000..99999999)}",
		street: "#{rand(1..100)} Avenue Kléber",
		city: "Paris",
		zip_code: "75016",
		country: "France",
		description: "Un super être humain qui est tout le temps positif à propos de tout!",
		user: user
	)
end
puts '5 users with profiles have been seeded'



categories.each do |category_title|
  Category.create!(
    title: category_title
  )
end
puts 'All categories have been seeded'


10.times do 
	child = Child.create!(
		nickname:Faker::Dessert.variety,
		birthday:Faker::Date.birthday(1, 12),
		sex: rand(1..2),
		profile:Profile.all.sample
		)
end
puts '10 children have been seeded'


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
