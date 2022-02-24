FactoryBot.define do
  factory :comment do
    association :post
    content { Faker::Lorem.paragraph }
    creator { Faker::Lorem.paragraph }
  end
end