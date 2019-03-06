FactoryBot.define do
  factory :user, aliases: [:owner]  do
    name "aa"
    sequence(:email) {|n| "aa#{n}@aa.aa"}
    password "aaaaaa"
    password_confirmation "aaaaaa"
    
    
    factory :email_without_atmark do
      email "aa.aa"
    end
    
    trait :email_without_dot do
      email "aa@aa"
    end
    
    trait :normal_email do
      email "aa@aa.aa"
    end
    
    #activated true
  end
end
