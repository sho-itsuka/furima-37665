FactoryBot.define do
  factory :item do
    title       { Faker::Lorem.sentence }
    price       { Faker::Number.between(from: 300, to: 9999999) }
    description { Faker::Lorem.sentence }
    category_id    { 2 }
    item_status_id { 2 }
    ship_cost_id   { 2 }
    ship_day_id    { 2 }
    ship_area_id   { 2 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
