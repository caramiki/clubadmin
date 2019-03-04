# == Schema Information
#
# Table name: clubs
#
#  id          :bigint(8)        not null, primary key
#  description :text
#  name        :string           not null
#  timezone    :string           default("Etc/UTC"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  creator_id  :bigint(8)
#
# Indexes
#
#  index_clubs_on_creator_id  (creator_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#

require "rails_helper"

RSpec.describe Club, type: :model do
  let(:club) { create(:club) }

  describe "TimezoneOptions" do
    it "has all the time zones" do
      expect(Club.timezone_options).to eq ActiveSupport::TimeZone.all.map { |t| [t.to_s, t.tzinfo.name] }
    end

    it "has time zone labels" do
      expect(Club.timezone_labels).to eq Club.timezone_options.map { |t| t[0] }
    end

    it "has time zone names" do
      expect(Club.timezone_names).to eq Club.timezone_options.map { |t| t[1] }
    end
  end

  describe "#associated_with?" do
    it "returns true for a user that is associated with the club" do
      admin = create(:role, :admin, club: club).user
      organizer = create(:role, :organizer, club: club).user
      creator = club.creator

      expect(club.associated_with?(admin)).to be true
      expect(club.associated_with?(organizer)).to be true
      expect(club.associated_with?(creator)).to be true
    end

    it "returns false for a user that is not associated with the club" do
      some_user = create(:user)

      expect(club.associated_with?(some_user)).to be false
    end
  end

  it "makes the creator an admin of the club" do
    expect(club.creator.admin_of?(club)).to be true
  end
end
