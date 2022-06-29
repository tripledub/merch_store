FactoryBot.define do
  factory :discount_rule do
    quantity { 1 }
    discount { 1 }
    product { nil }
    code { 'foo' }
  end
end
