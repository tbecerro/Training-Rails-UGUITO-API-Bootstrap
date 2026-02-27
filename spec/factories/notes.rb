FactoryBot.define do
  factory :note do
    title { Faker::TvShows::BojackHorseman.character }
    content { Faker::Lorem.paragraph }
    note_type { :critique }
    association :user
  end
end
