name_category = ["Soins bébé", "Chaises hautes & sièges auto", "Poussettes", "Mobilier enfant", "Jeux & Jouets", "Livres & Scolarité", "Sécurité", "Allaitement & Repas", "Vêtements"]

FactoryBot.define do
  factory :category do
    title { name_category.sample }
  end
end
