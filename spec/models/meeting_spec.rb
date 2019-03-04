# == Schema Information
#
# Table name: meetings
#
#  id                :bigint(8)        not null, primary key
#  attendances_count :integer          default(0), not null
#  description       :text
#  end_time          :datetime
#  notes             :text
#  start_time        :datetime         not null
#  title             :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  club_id           :bigint(8)        not null
#
# Indexes
#
#  index_meetings_on_club_id  (club_id)
#
# Foreign Keys
#
#  fk_rails_...  (club_id => clubs.id)
#

require "rails_helper"

RSpec.describe Meeting, type: :model do
  let(:meeting) { create(:meeting) }

  describe "validations" do
    it "allows an end time after the start time" do
      start_time = DateTime.current
      end_time = start_time + 1.hour

      expect(meeting.update(start_time: start_time, end_time: end_time)).to be true
    end

    it "does not allow the end time to be before the start time" do
      end_time = meeting.start_time - 1.day
      end_time_error_message = Meeting.human_attribute_name(:end_time) + " " +
        I18n.t(".activerecord.errors.models.meeting.attributes.end_time.after_start_time")

      expect(meeting.update(end_time: end_time)).to be false
      expect(meeting.errors.full_messages).to include end_time_error_message
    end
  end

  describe "#associated_with?" do
    it "returns true for a user that is associated with the meeting" do
      admin = create(:role, :admin, club: meeting.club).user
      organizer = create(:role, :organizer, club: meeting.club).user
      creator = meeting.club.creator

      expect(meeting.associated_with?(admin)).to be true
      expect(meeting.associated_with?(organizer)).to be true
      expect(meeting.associated_with?(creator)).to be true
    end

    it "returns false for a user that is not associated with the meeting" do
      some_user = create(:user)

      expect(meeting.associated_with?(some_user)).to be false
    end
  end

  describe "#date" do
    it "returns the date of the meeting as a string" do
      expect(meeting.date).to eq meeting.start_time.strftime("%b %-d, %Y")
    end
  end

  describe "#date_and_time" do
    it "returns a formatted date range" do
      start_time = DateTime.new(2018, 6, 1, 18)
      end_time = DateTime.new(2018, 6, 1, 20, 30)
      meeting.update(start_time: start_time, end_time: end_time)

      expect(meeting.date_and_time).to eq "Jun 1, 2018 6–8:30 PM"
    end

    it "returns the formatted start day and time if there is no end time" do
      start_time = DateTime.new(2018, 6, 1, 18)
      meeting.update(start_time: start_time, end_time: nil)

      expect(meeting.date_and_time).to eq "Jun 1, 2018 6 PM"
    end

    it "returns a formatted date range with both the start and end days if the start and end days are different" do
      start_time = DateTime.new(2018, 6, 1, 18)
      end_time = DateTime.new(2018, 6, 2, 1, 30)
      meeting.update(start_time: start_time, end_time: end_time)

      expect(meeting.date_and_time).to eq "Jun 1, 2018 6 PM – Jun 2, 2018 1:30 AM"
    end
  end

  describe "#end_time_display" do
    it "returns the formatted start time" do
      start_time = DateTime.new(2018, 6, 1, 18)
      end_time = DateTime.new(2018, 6, 1, 20, 30)
      meeting.update(start_time: start_time, end_time: end_time)

      expect(meeting.end_time_display).to eq "Jun 1, 2018 8:30 PM"
    end
  end

  describe "#start_time_display" do
    it "returns the formatted start time" do
      meeting.update(start_time: DateTime.new(2018, 6, 1, 18), end_time: nil)
      expect(meeting.start_time_display).to eq "Jun 1, 2018 6 PM"
    end
  end

  describe "#title_display" do
    it "returns the title of the meeting if present" do
      expect(meeting.title_display).to be meeting.title
      meeting.update(title: "Something")
      expect(meeting.title).to eq "Something"
    end

    it "returns a placeholder meeting title with the date if no title is present" do
      meeting.update(title: "")
      expect(meeting.title_display).to eq "#{meeting.date} #{Meeting.name}"
    end
  end
end
