categories = ["Soins bébé", 
	          "Chaises hautes & sièges auto", 
	          "Poussettes", "Mobilier enfant", 
	          "Jeux & Jouets", 
	          "Livres & Scolarité", 
	          "Sécurité", 
	          "Allaitement & Repas", 
	          "Vêtements",
	          "Autres"
	          ]

sizes = ["Femmes enceinte", "Prématuré", 
	          "Nouveau né", 
	          "Jusqu'à 1 mois", "0 - 3 mois", 
	          "3 - 6 mois", 
	          "6 - 9 mois", 
	          "9 - 12 mois", 
	          "12 - 18 mois", 
	          "18 - 24 mois",
	          "24 - 36 mois",
	          "4 ans", "5 ans", "6 ans", "7 ans", "8 ans", "9 ans", "10 ans", "11 ans", "12 ans", "Autres"
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



categories.each do |category_title|
  Category.create!(
    title: category_title
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
	)
end
puts '20 products have been seeded'
