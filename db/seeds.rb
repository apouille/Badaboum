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

categories.each do |category|
  Category.create!(
    title: category[0],
    icon: category[1]
  )
end

puts 'All categories have been seeded'

sizes = ["Prématuré", 
	          "Nouveau né", 
	          "Jusqu'à 1 mois", "0 - 3 mois", 
	          "3 - 6 mois", 
	          "6 - 9 mois", 
	          "9 - 12 mois", 
	          "12 - 18 mois", 
	          "18 - 24 mois",
	          "24 - 36 mois",
	          "4 ans", "5 ans", "6 ans", "7 ans", "8 ans", "9 ans", "10 ans", "11 ans", "12 ans", "Femme enceinte", "Unique"
	          ]

sizes.each do |size_title|
  Size.create!(
    title: size_title
  )
end

puts 'All sizes have been seeded'

admin_user = User.create!(
	email: "badaboum@yopmail.com",
	password: "test1234",
  	is_admin: true
)

puts 'Admin user has been seeded'

admin_user.profile.update(
  	first_name: 'Admin',
  	last_name: 'Badaboum',
  	phone_number: "0607080910",
  	street: '5 Parvis Alan Turing',
  	city: 'Paris',
  	zip_code: "75013",
  	description: "Venez me retrouver à la Félichita pour prendre un verre!",
  	user: admin_user
)

puts 'Admin profile has been seeded'

