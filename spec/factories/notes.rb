FactoryBot.define do
  factory :note do
    title { :title }
    content { :content }
    note_type { :critique }
    association :user
  end
end
