FactoryBot.define do
  factory :comment do
    association :user
    association :post

    body { FFaker::Lorem.sentence }
  end
end
