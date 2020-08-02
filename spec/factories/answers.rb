FactoryBot.define do
  factory :answer do
    user
		question
    body
    trait :invalid do
      body { nil }
    end
  end
end
