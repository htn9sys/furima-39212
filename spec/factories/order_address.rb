FactoryBot.define do
  factory :order_address do
    token         {"tok_abcdefghijk00000000000000000"}
    post_code     { "123-4567" }
    prefecture_id { 2 }
    municipality  { "函館市" }
    address       { "花園町24番2号" }
    phone_number  { "09000000000" }
    building      { "テストビル" }
  end
end
