FactoryBot.define do
  factory :role do
    club { create(:club) }
    user { create(:user) }
    level { :admin }

    trait :organizer do
      level { :organizer }
    end

    trait :admin do
      level { :admin }
    end
  end
end
