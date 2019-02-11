FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    password { "password" }
    password_confirmation { "password" }
    super_admin { false }

    trait :super_admin do
      super_admin { true }
    end
  end
end
