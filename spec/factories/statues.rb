FactoryBot.define do
  factory :statue do
    name    { '釈迦如来' }
    ruby    { 'しゃかにょらい' }
    grade   { '如来' }
    content { 'テスト' }

    trait :with_spots do
      after(:build) do |statue|
        statue.spots << FactoryBot.build(:spot)
      end
    end
  end
end
