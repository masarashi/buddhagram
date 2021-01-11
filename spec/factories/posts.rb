FactoryBot.define do
  factory :post do
    association :user
    content     { "Hello, World!" }

    trait :with_hashtags do
      content { "#釈迦" }
    end

    trait :with_spots do
      association :spot
    end

    after(:build) do |post|
      post.images.attach(io: File.open('spec/images/sample_image.png'), filename: 'sample_image.png',
                         content_type: 'image/png')
    end
  end
end
