FactoryBot.define do
  factory :post do
    content "hello"
    association :owner
  end
end
