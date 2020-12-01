FactoryBot.define do
  factory :comment do
    content     { "Nice Post!" }
    association :post
    association :user
  end
end
