FactoryBot.define do
  factory :member do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    notes { FFaker::Lorem.paragraph(rand(1..5)) }
    club_id { create(:club).id }

    trait :invalid do
      first_name { "" }
      last_name { "" }
    end
  end
end
