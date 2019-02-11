FactoryBot.define do
  factory :user, aliases: [:owner]  do
    name "Basyo Matsuo"
    sequence(:email) {|n| "aa#{n}@aa.aa"}
    password "aaaaaa"
    password_confirmation "aaaaaa"
    
    factory :email_without_atmark do
      email "aa.aa"
    end
    
    trait :email_without_dot do
      email "aa@aa"
    end
    
    trait :five_poemer do
    end
    
  end
end
