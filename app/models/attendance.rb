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

class Attendance < ApplicationRecord
  belongs_to :meeting, inverse_of: :attendances
  belongs_to :attendee, inverse_of: :attendances, class_name: "Member", foreign_key: "member_id"

  validates :meeting, presence: true
  validates :attendee, presence: true
  validates :meeting, uniqueness: { scope: :attendee }

  def associated_with?(user)
    club.users.include? user
  end

  def club
    meeting.club
  end
end
