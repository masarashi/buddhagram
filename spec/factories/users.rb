FactoryBot.define do
  factory :user do
    sequence(:name)   { |n| "user#{n}" }
    sequence(:email)  { |n| "tester#{n}@example.com" }
    password          { 'hogehoge' }

    trait :admin do
      admin { 'true' }
    end

    after(:build) do |user|
      user.image.attach(io: File.open('spec/images/user-icon.png'), filename: 'user-icon.png',
                        content_type: 'image/png')
    end
  end
end
