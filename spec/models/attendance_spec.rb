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
end
