# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rails db:seed command
# (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Admin User
FactoryBot.create(:admin_user, email: 'admin@example.com', password: 'password',
                               password_confirmation: 'password')

# Utilities
north_utility = FactoryBot.create(:north_utility, code: 1)
south_utility = FactoryBot.create(:south_utility, code: 2)

# Users
FactoryBot.create_list(:user, 20, utility: north_utility,
                                  password: '12345678', password_confirmation: '12345678')
FactoryBot.create_list(:user, 20, utility: south_utility,
                                  password: '12345678', password_confirmation: '12345678')

FactoryBot.create(:user, utility: south_utility, email: 'test_south@widergy.com',
                         password: '12345678', password_confirmation: '12345678')

FactoryBot.create(:user, utility: north_utility, email: 'test_north@widergy.com',
                         password: '12345678', password_confirmation: '12345678')

# Notes
FactoryBot.create(:note, title: "Prueba short North Utility", content:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gge",  user_id:42)
FactoryBot.create(:note, title: "Prueba medium North Utility", content:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa", user_id:42)
FactoryBot.create(:note, title: "Prueba large North Utility", content:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa  Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown when an unknown when an unknown when an unknown", user_id:42)

FactoryBot.create(:note, title: "Pueba short South Utiltiy", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry" , user_id:41)
FactoryBot.create(:note, title: "Pueba medium South Utiltiy", content: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry  since the 1500s, when an unknown printer took a gafa Ipsum has been the industry", user_id:41)
FactoryBot.create(:note, title: "Pueba large South Utiltiy", content:"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a gafa Ipsum has been the industry  since the 1500s, when an unknown printer took a gafa Ipsum has been the industry the 1500s, when an unknown printer took a gafa Ipsum has been the industry  since the 1500s, when an unknown printer took a gafa Ipsum has been the industry  the 1500s, when an unknown printer took a gafa Ipsum has been the industry  since the 1500s, when an unknown printer took a gafa Ipsum has been the industry" , user_id:41)


User.all.find_each do |user|
  random_books_amount = [1, 2, 3].sample
  FactoryBot.create_list(:book, random_books_amount, user: user, utility: user.utility)
end
