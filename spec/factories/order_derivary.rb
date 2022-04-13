FactoryBot.define do
  factory :order_delivary do
    postcode { '123-4567' }
    ship_area_id { 3 }
    city { 'あああ市' }
    block { '1-1-1' }
    building { 'あああアパート' }
    phonenumber { '09011112222' }
    token { 'tok_abcdefghijk00000000000000000' }
  end
end
