# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'

admin = User.new(
  email: 'admin@email.com',
  password: 'Test1234!', 
  password_confirmation: 'Test1234!',
  username: 'petnet_admin',
  location: 'Pasig',
  role: 0,
  approved: true,
)

if admin.save
  puts 'Admin successfully created'
end

shelter_ids = Shelter.pluck(:id)

ncr_cities = [
  "Caloocan",
  "Las Piñas",
  "Makati",
  "Malabon",
  "Mandaluyong",
  "Manila",
  "Marikina",
  "Muntinlupa",
  "Navotas",
  "Parañaque",
  "Pasay",
  "Pasig",
  "Quezon City",
  "San Juan",
  "Taguig",
  "Valenzuela",
  "Pateros"
]

10.times do
  Pet.create!(
    shelter_id: shelter_ids.sample,
    name: Faker::Creature::Dog.name,
    species: %w[Dog Cat].sample,
    breed: Faker::Creature::Dog.breed,
    age: rand(1..10),
    size: %w[Small Medium Large].sample,
    gender: %w[Male Female].sample,
    temperament: %w[Calm Playful Aggressive Friendly].sample,
    description: Faker::Lorem.paragraph,
    photo_url: Faker::LoremFlickr.image(search_terms: ['pet']),
    adoption_status: 0,
    location: ncr_cities.sample
  )
end
