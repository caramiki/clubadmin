FactoryBot.define do
  factory :meeting do
    start_time { DateTime.current.beginning_of_hour }
    end_time { DateTime.current.beginning_of_hour + 2.hours }
    title { FFaker::Lorem.words(rand(1..5)).join(" ").titleize }
    club_id { create(:club).id }
  end
end
