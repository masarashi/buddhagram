FactoryBot.define do
  factory :post do
    content     { "Hello, World!" }
    association :user

    after(:build) do |post|
      post.images.attach(io: File.open('spec/images/sample_image.png'), filename: 'sample_image.png', content_type: 'image/png')
    end
  end
end
