FactoryBot.define do
  factory :attendance do
    meeting_id { create(:meeting).id }
    member_id { create(:member).id }
  end
end
