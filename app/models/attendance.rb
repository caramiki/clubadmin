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
  include DateAndTimeFormattable

  belongs_to :meeting, inverse_of: :attendances, counter_cache: true
  belongs_to :attendee, inverse_of: :attendances, class_name: "Member", foreign_key: "member_id", counter_cache: true

  validates :meeting, presence: true
  validates :attendee, presence: true
  validates :meeting, uniqueness: { scope: :attendee }
  validate :departure_time_after_arrival_time

  def arrival_time_display
    date_and_time_format(arrival_time) if arrival_time.present?
  end

  def associated_with?(user)
    club.users.include? user
  end

  def club
    meeting.club
  end

  def departure_time_display
    date_and_time_format(departure_time) if departure_time.present?
  end

  private

  def departure_time_after_arrival_time
    return if arrival_time.blank? || departure_time.blank?

    errors.add(:departure_time, :after_arrival_time) if departure_time < arrival_time
  end
end
