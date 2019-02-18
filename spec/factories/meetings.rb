# == Schema Information
#
# Table name: meetings
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  end_time    :datetime
#  notes       :text
#  start_time  :datetime         not null
#  title       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  club_id     :bigint(8)        not null
#
# Indexes
#
#  index_meetings_on_club_id  (club_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#

FactoryBot.define do
  factory :meeting do
    start_time { DateTime.current.beginning_of_hour }
    end_time { DateTime.current.beginning_of_hour + 2.hours }
    title { FFaker::Lorem.words(rand(1..5)).join(" ").titleize }
    description { FFaker::Lorem.paragraph(rand(1..5)) }
    notes { FFaker::Lorem.paragraph(rand(1..5)) }
    club_id { create(:club).id }
  end
end
