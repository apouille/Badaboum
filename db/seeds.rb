categories = [
	["Soins bébé", "fas fa-bath"],
	["Transports", "fas fa-baby-carriage"],
	["Mobilier enfant", "fas fa-campground"],
	["Jeux & Jouets", "fas fa-dice"],
	["Livres & Scolarité", "fas fa-book"],
	["Sécurité", "fas fa-hard-hat"],
	["Allaitement & Repas", "fas fa-utensils"],
	["Vêtements", "fas fa-tshirt"],
	["Autres", "fas fa-ellipsis-h"]  
]

sizes = ["Prématuré", 
	          "Nouveau né", 
	          "Jusqu'à 1 mois", "0 - 3 mois", 
	          "3 - 6 mois", 
	          "6 - 9 mois", 
	          "9 - 12 mois", 
	          "12 - 18 mois", 
	          "18 - 24 mois",
	          "24 - 36 mois",
	          "4 ans", "5 ans", "6 ans", "7 ans", "8 ans", "9 ans", "10 ans", "11 ans", "12 ans", "Femmes enceintes", "Autres"
	          ]
users = [
	["bastien.hiel@yopmail.com", "Bastien", "Hiel"],
	["claudia.partonnau@yopmail.com", "Claudia", "Partonnau"],
	["maxime.speroni@yopmail.com", "Maxime", "Speroni","acct_1EEvb4EZvBvGXd8M"],
	["viviane.depetigny@yopmail.com", "Viviane", "de Pétigny"],
	["melanie.nguon@yopmail.com", "Mélanie", "Nguon"]
]

users.each do |u|
	user = User.create!(
		email: u[0],
		password: "test1234",
		stripe_uid: u[3],
		is_admin: true
	)
end
puts '5 users have been seeded'


i = 1
users.each do |u|
	profile = Profile.find(i)
	profile.update(
		first_name: u[1],
		last_name: u[2],
		phone_number: "06#{rand(10000000..99999999)}",
		street: "#{rand(1..100)} Avenue Kléber",
		city: "Paris",
		zip_code: "75016",
		country: "France",
		description: "Un super être humain qui est tout le temps positif à propos de tout!",
		user_id: i
		)
	profile.save
	i += 1
end
puts '5 profiles have been seeded'



categories.each do |category|
  Category.create!(
    title: category[0],
    icon: category[1]
  )
end
puts 'All categories have been seeded'

sizes.each do |size_title|
  Size.create!(
    title: size_title
  )
end
puts 'All sizes have been seeded'


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
		seller: User.all.sample, 
		category: Category.all.sample,
		size: Size.all.sample,	
		state: 1
	)
end
puts '20 products have been seeded'


