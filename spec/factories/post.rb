FactoryBot.define do
  factory :post do
    association :user

    title { FFaker::Lorem.sentence }
    body { FFaker::Lorem.sentence }

    trait :image_attached do
      after(:build) do |post|
        post.image.attach(
          io: File.open(Rails.root.join('spec', 'support', 'assets', 'pixel.png')),
          filename: 'pixel.png',
          content_type: 'image/png'
        )
      end
    end
  end
end
