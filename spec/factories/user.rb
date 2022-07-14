FactoryBot.define do
  factory :user do
    name { FFaker::Lorem.sentence }
    email { FFaker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
