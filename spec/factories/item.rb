FactoryBot.define do
  factory :item do
    image         { Rack::Test::UploadedFile.new(File.open("#{Rails.root}/test_image/1.png")) }
    name          { Faker::Lorem.sentence }
    explanation   { Faker::Lorem.sentence }
    category_id   { 2 }
    condition_id  { 2 }
    postage_id    { 2 }
    prefecture_id { 2 }
    sender_id     { 2 }
    price         { Faker::Number.between(from: 300, to: 9999999) }
    association :user
  end
end