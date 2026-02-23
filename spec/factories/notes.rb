FactoryBot.define do
  factory :note do
    title { Faker::Food.ethnic_category }
    content { Faker::Food.description }
    note_type { :critique }
    association :user
  end
end
