FactoryBot.define do
  factory :spot do
    name        { '法隆寺' }
    country     { '日本' }
    state       { '奈良県' }
    address     { '〒636-0115 奈良県生駒郡斑鳩町法隆寺山内１−１−１' }
    latitude    { '34.6141' }
    longitude   { '135.736' }
    content     { 'テスト' }

    trait :with_statues do
      after(:build) do |spot|
        spot.statues << FactoryBot.build(:statue)
      end
    end
  end
end
