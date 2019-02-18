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

require 'rails_helper'

RSpec.describe Attendance, type: :model do
  let(:attendance) { create(:attendance) }

  describe "validations" do
    it "allows a departure time after the arrival time" do
      arrival_time = attendance.meeting.start_time
      departure_time = attendance.meeting.end_time

      expect(attendance.update(arrival_time: arrival_time, departure_time: departure_time)).to be true
    end

    it "does not allow the departure time to be before the arrival time" do
      arrival_time = attendance.meeting.start_time
      departure_time = arrival_time - 1.hour

      departure_time_error_message = Attendance.human_attribute_name(:departure_time) + " " +
        I18n.t(".activerecord.errors.models.attendance.attributes.departure_time.after_arrival_time")

      expect(attendance.update(arrival_time: arrival_time, departure_time: departure_time)).to be false
      expect(attendance.errors.full_messages).to include departure_time_error_message
    end
  end

  describe "#arrival_time_display" do
    it "returns the formatted arrival time" do
      attendance.update(arrival_time: DateTime.new(2018, 6, 1, 18), departure_time: nil)

      expect(attendance.arrival_time_display).to eq "Jun 1, 2018 6 PM"
    end
  end

  describe "#associated_with?" do
    it "returns true for a user that is associated with the attendance" do
      admin = create(:role, :admin, club: attendance.club).user
      organizer = create(:role, :organizer, club: attendance.club).user
      creator = attendance.club.creator

      expect(attendance.associated_with?(admin)).to be true
      expect(attendance.associated_with?(organizer)).to be true
      expect(attendance.associated_with?(creator)).to be true
    end

    it "returns false for a user that is not associated with the attendance" do
      some_user = create(:user)

      expect(attendance.associated_with?(some_user)).to be false
    end
  end

  describe "#club" do
    it "returns the club associated with the attendance" do
      expect(attendance.club).to eq attendance.meeting.club
      expect(attendance.club).to eq attendance.attendee.club
    end
  end

  describe "#departure_time_display" do
    it "returns the formatted departure time" do
      attendance.update(arrival_time: nil, departure_time: DateTime.new(2018, 6, 1, 18))

      expect(attendance.departure_time_display).to eq "Jun 1, 2018 6 PM"
    end
  end
end
