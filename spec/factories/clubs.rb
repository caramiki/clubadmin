FactoryBot.define do
  factory :club do
    name { FFaker::Lorem.words(rand(1..5)).join(" ").titleize }
    description { FFaker::Lorem.paragraph(rand(1..5)) }
    creator_id { create(:user).id }

    trait :invalid do
      name { "" }
    end
  end
end
