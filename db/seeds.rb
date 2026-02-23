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
note_config = [
  {
    user:42, words: 49, content_type: 'short', utility: "North"
  },
   {
    user:42, words: 99, content_type: 'medium', utility: "North"
  },
  {
    user:42, words: 102, content_type: 'large', utility: "North" 
  },
  {
    user:41, words: 59, content_type: 'short', utility: "South" 
  },
  {
    user:41, words: 109, content_type: 'medium', utility: "South" 
  },
  {
    user:41, words: 129, content_type: 'large', utility: "South" 
  },
]

note_config.each do |config|
  FactoryBot.create(:note,
    title: "Nota #{config[:content_type]} #{config[:utility]}",
    content: Faker::Lorem.words(number: config[:words]).join(' '),
    user_id: config[:user]
  )
end

User.all.find_each do |user|
  random_books_amount = [1, 2, 3].sample
  FactoryBot.create_list(:book, random_books_amount, user: user, utility: user.utility)
end
