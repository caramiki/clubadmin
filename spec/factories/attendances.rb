# == Schema Information
#
# Table name: attendances
#
#  id             :bigint(8)        not null, primary key
#  arrival_time   :datetime
#  departure_time :datetime
#  notes          :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  meeting_id     :bigint(8)        not null
#  member_id      :bigint(8)        not null
#
# Indexes
#
#  index_attendances_on_meeting_id  (meeting_id)
#  index_attendances_on_member_id   (member_id)
#
# Foreign Keys
#
#  fk_rails_...  (meeting_id => meetings.id)
#  fk_rails_...  (member_id => members.id)
#

FactoryBot.define do
  factory :attendance do
    meeting_id { create(:meeting).id }
    member_id { create(:member, club: meeting.club).id }
    arrival_time { meeting.start_time }
    departure_time { meeting.end_time }

    trait :invalid do
      arrival_time { meeting.start_time }
      departure_time { meeting.start_time - 1.hour }
    end
  end
end
