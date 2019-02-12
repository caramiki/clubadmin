# == Schema Information
#
# Table name: members
#
#  id         :bigint(8)        not null, primary key
#  first_name :string
#  last_name  :string
#  notes      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  club_id    :bigint(8)        not null
#  user_id    :bigint(8)
#
# Indexes
#
#  index_members_on_club_id  (club_id)
#  index_members_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#  fk_rails_...  (user_id => users.id)
#

require "rails_helper"

RSpec.describe Member, type: :model do
  let(:member) { create(:member) }

  describe "#associated_with?" do
    it "returns true for a user that is associated with the member" do
      admin = create(:role, :admin, club: member.club).user
      organizer = create(:role, :organizer, club: member.club).user
      creator = member.club.creator

      expect(member.associated_with?(admin)).to be true
      expect(member.associated_with?(organizer)).to be true
      expect(member.associated_with?(creator)).to be true
    end

    it "returns false for a user that is not associated with the member" do
      some_user = create(:user)

      expect(member.associated_with?(some_user)).to be false
    end
  end

  describe "#attendance" do
    it "returns the member's attendance for a given meeting" do
      meeting = create(:meeting, club: member.club)
      attendance = create(:attendance, meeting: meeting, member: member)

      expect(member.attendance(meeting)).to eq attendance
    end
  end

  describe "#attended?" do
    let(:meeting) { create(:meeting, club: member.club) }

    it "returns true if the member attended the meeting" do
      attendance = create(:attendance, meeting: meeting, member: member)

      expect(member.attended?(meeting)).to be true
    end

    it "returns false if the member did not attend the meeting" do
      expect(member.attended?(meeting)).to be false
    end
  end
end
