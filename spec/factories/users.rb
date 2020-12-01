FactoryBot.define do
  factory :user do
    sequence(:name)   { |n| "user#{n}" }
    sequence(:email)  { |n| "tester#{n}@example.com" }
    password          { "hogehoge" }
  end
end
